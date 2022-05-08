# frozen_string_literal: true

class Factory
  # cf. https://www.sukerou.com/2018/06/yahoo-api.html
  ##
  # 日本語形態素解析の実行
  # @param sentence 解析対象のテキスト
  # @return 形態素解析の結果
  # [
  #   {
  #     Surface: "庭"    //形態素の表記
  #     reading: "にわ"  //形態素の読みがな
  #     pos: "名詞"      //形態素の品詞
  #   }
  #   ,
  #   ...
  # ]
  def random_sentence(noun = nil)
    noun ||= Word.where(pos: '名詞').sample(1).first.surface
    markov_dic = MarkovDic.where(prefix_1: noun).sample(1).first
    return noun unless markov_dic

    markov_dic.create_sentence(markov_dic.prefixes, markov_dic)
  end

  # 形態素解析を行い、WordレコードとMarkovDicレコードを作成する。名詞の配列を返す。
  def record(text, user)
    text = remove_url(text)
    morphological_words = exec(text)

    poses = Word.save_words(morphological_words, user)
    save_markov_dics(morphological_words)

    poses
  end

  private

  def remove_url(text)
    URI.extract(text).uniq.each { |url| text.gsub!(url, '') }
    text
  end

  def exec(text)
    # URLおよびクエリパラメタ設定
    url = URI.parse('https://jlp.yahooapis.jp/MAService/V1/parse')
    url.query = [
      "appid=#{URI.encode_www_form_component(ENV.fetch('YAHOO_CLIENT_ID', nil))}",
      'results=ma',
      "sentence=#{URI.encode_www_form_component(text)}"
    ].join('&')

    # getリクエスト送信
    res = get_request(url, use_ssl: true)

    # エラーの場合、nilを返却
    return nil if res.code != '200'

    # xml解析する
    words = []
    doc = REXML::Document.new(res.body)
    # - word要素分繰り返し
    doc.elements.each('//ma_result/word_list/word') do |el|
      # - wordタグ内の各要素を読み取って、hashに格納
      words << %w[surface reading pos].each_with_object({}) do |nm, h|
        child_el = el.get_elements(nm)[0]
        h[nm] = child_el.nil? ? nil : child_el.text
      end
    end

    words
  end

  ##
  # GETリクエストを送信し、そのレスポンスを取得する
  # @param url リクエストURL
  # @return レスポンス
  def get_request(url, use_ssl: true)
    req = Net::HTTP::Get.new(url.request_uri)

    # getリクエスト送信
    Net::HTTP.start(url.host, url.port, use_ssl: use_ssl) do |http|
      http.request(req)
    end
  end

  # rubocop:disable  Naming/VariableNumber
  def save_markov_dics(morphological_words)
    markov_dics = []
    morphological_words.each_cons(3) do |p1, p2, suf|
      next if p1['surface'] == "\n"
      next if p2['surface'] == "\n"

      md = MarkovDic.new(prefix_1: p1['surface'], prefix_2: p2['surface'], suffix: suf['surface'])
      md.suffix = 'END_OF_SENTENCE' if md.suffix == "\n"
      markov_dics << md.attributes.compact!.merge({ created_at: now, updated_at: now })
    end
    eos = morphological_words.last(2)
    if eos.size == 2
      p1 = eos[0]
      p2 = eos[1]
      md = MarkovDic.new(prefix_1: p1['surface'], prefix_2: p2['surface'], suffix: 'END_OF_SENTENCE')
      markov_dics << md.attributes.compact!.merge({ created_at: now, updated_at: now })
    end
    MarkovDic.insert_all(markov_dics) if markov_dics.present?
  end
  # rubocop:enable  Naming/VariableNumber

  def now
    Time.zone.now
  end
end
