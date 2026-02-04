問題1 部署テーブルの作成
CREATE TABLE departments (
  depertment_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '部署ID',
  name VARCHAR(20) NOT NULL COMMENT '部署名',
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
  );

  問題2 pepleテーブルにカラムの追加
  alter table people add depertment_id INT(10) UNSIGNED NULL after email;

  問題3 各レコード追加
  *departments Tableに営業、開発、経理、人事、情報システムを追加
  Insert into departments(name) values 
  ('営業'),
  ('開発'),
  ('経理'),
  ('人事'),
  ('情報システム');

  *people Tableに10人追加 営業3人、開発4人、経理1人、人事1人、情報システム1人
  insert into people (name,email,depertment_id,age,gender) values 
  ('斎藤一','s.hazime@gizumo.com','1','59','1'),
  ('水落二郎','m.zirou@gizumo.com','1','47','1'),
  ('谷合みつめ','t.mitsume@gizumo.com','1','38','2'),
  ('山吹四郎','y.shirou@gizumo.com','2','21','1'),
  ('東堂いつき','t.itsuki@gizumo.com','2','55','2'),
  ('新城・ロック','s.rokku@gizumo.com','2','26','1'),
  ('灰谷七海','h.nanami@gizumo.com','2','41','2'),
  ('八岐大蛇','y.oroti@gizumo.com','3','44','2'),
  ('九十九由紀','t.yuki@gizumo.com','4','37','2'),
  ('東堂十郎','t.zyurou@gizumo.com','5','20','1');

  *reports Tableに10件追加 日報は誰につけてもいいが存在しないperson_idにつけない 最低10文字以上 同じ日報は作らない
  insert into reports (person_id,content) values
  ('7','7日目、飛行機の不時着により無人島に流れ着いてからの日数だ'),
  ('8','8日目。備蓄もなくなりかけてきたところで川を見つけた'),
  ('9','9日目。釣りに成功。食料もなんとかなりそうだ'),
  ('10','10日目。拠点を立派なものに作り変えた。希望が見える'),
  ('11','11日目。鹿を狩ることに成功。久々に満腹だ'),
  ('12','12日目。遠くに煙が見えた。他に人がいるのか？'),
  ('13','13日目。煙の下には放棄された集落があった。何があった？'),
  ('14','14日目。昨日帰ってから、何かに監視されているような気がする'),
  ('15','15日目。外に何かいる。気が狂いそうだ'),
  ('16','16日目。なんてことだ、あれは(日記はここで途切れている)');

  問題4 people Tableのdepertomet_idを修正 depertment_idがNULLになっているのを部署割り振り
  update people set depertment_id = '1' where person_id = 1;
  update people set depertment_id = '2' where person_id = 2;
  update people set depertment_id = '3' where person_id = 3;
  update people set depertment_id = '4' where person_id = 4;
  update people set depertment_id = '5' where person_id = 6;

  問題5 年齢の降順で男性の名前と年齢を取得
  select name,age from people 
    where
      gender = '1'
    order by 
      age desc;

  問題6 テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL分を日本語で説明してください
  SELECT
  `name`, `email`, `age`
  FROM
    `people`
  WHERE
    `department_id` = 1
  ORDER BY
    `created_at`;  

  peopleテーブルからname,email,ageの3つのカラムを取得
  depertment_idが1のみを取得する
  created_atで昇順にレコードを並び替える

  問題7 20代の女性と40代の男性の名前一覧を取得してください。
  select name from people
    where
      (gender = 2 
        and
      age between 20 and 29)
      or
      (gender = 1
        and
      age between 30 and 39);

問題8 営業部に所属する人だけを年齢の昇順で取得してください。
select p.* from people as p 
  inner join
    departments as d ON
    p.depertment_id = d.depertment_id
  WHERE
    d.name = '営業';

問題9 開発部に所属している女性の平均年齢を取得してください。 カラム名はavarage_ageとなるようにしましょう
select AVG(p.age) as avarage_age from people as p 
  inner join
    departments as d ON
    p.depertment_id = d.depertment_id
where
  p.gender = '2'
and
  d.depertment_id = '2';

問題10 名前と部署名とその人が提出した日報の内容を同時に取得してください(日報を提出していない人は含めない)
select p.name,d.name,r.content from people as p
  inner join departments as d on 
    p.depertment_id = d.depertment_id
  left outer join reports as r on
    p.person_id = r.person_id
  where
    r.content is not null;

問題11 日報を一つも提出していない人の名前一覧を取得してください
select p.name from people as p
  left outer join reports as r on
    p.person_id = r.person_id
  where 
    r.content is null;
