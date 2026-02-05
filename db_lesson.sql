/* ------------ 問題1 部署テーブルの作成 ------------*/
CREATE TABLE departments (
  department_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '部署ID',
  name VARCHAR(20) NOT NULL COMMENT '部署名',
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
  );

/* ------------ 問題2 pepleテーブルにカラムの追加 ------------*/
  ALTER TABLE people ADD department_id INT(10) UNSIGNED NULL AFTER email;

/* ------------ 問題3 各レコード追加 ------------ */
/* ------------ *departments Tableに営業、開発、経理、人事、情報システムを追加 ------------ */
  INSERT INTO departments(name) VALUES 
  ('営業'),
  ('開発'),
  ('経理'),
  ('人事'),
  ('情報システム');

/* ------------*people Tableに10人追加 営業3人、開発4人、経理1人、人事1人、情報システム1人 ------------ */
  INSERT INTO people (name,email,department_id,age,gender) VALUES 
  ('斎藤一','s.hazime@gizumo.com',1,59,1),
  ('水落二郎','m.zirou@gizumo.com',1,47,1),
  ('谷合みつめ','t.mitsume@gizumo.com',1,38,2),
  ('山吹四郎','y.shirou@gizumo.com',2,21,1),
  ('東堂いつき','t.itsuki@gizumo.com',2,55,2),
  ('新城・ロック','s.rokku@gizumo.com',2,26,1),
  ('灰谷七海','h.nanami@gizumo.com',2,41,2),
  ('八岐大蛇','y.oroti@gizumo.com',3,44,2),
  ('九十九由紀','t.yuki@gizumo.com',4,37,2),
  ('東堂十郎','t.zyurou@gizumo.com',5,20,1);

/* ------------  *reports Tableに10件追加 
    日報は誰につけてもいいが存在しないperson_idにつけない 最低10文字以上 同じ日報は作らない ------------*/
  INSERT INTO reports (person_id,content) VALUES
  (7,'7日目、飛行機の不時着により無人島に流れ着いてからの日数だ'),
  (8,'8日目。備蓄もなくなりかけてきたところで川を見つけた'),
  (9,'9日目。釣りに成功。食料もなんとかなりそうだ'),
  (10,'10日目。拠点を立派なものに作り変えた。希望が見える'),
  (11,'11日目。鹿を狩ることに成功。久々に満腹だ'),
  (12,'12日目。遠くに煙が見えた。他に人がいるのか？'),
  (13,'13日目。煙の下には放棄された集落があった。何があった？'),
  (14,'14日目。昨日帰ってから、何かに監視されているような気がする'),
  (15,'15日目。外に何かいる。気が狂いそうだ'),
  (16,'16日目。なんてことだ、あれは(日記はここで途切れている)');

/* ------------ 問題4 people Tableのdepertomet_idを修正
   department_idがNULLになっているのを部署割り振り ------------ */
  UPDATE people SET department_id = 1 WHERE person_id = 1;
  UPDATE people SET department_id = 2 WHERE person_id = 2;
  UPDATE people SET department_id = 3 WHERE person_id = 3;
  UPDATE people SET department_id = 4 WHERE person_id = 4;
  UPDATE people SET department_id = 5 WHERE person_id = 6;

/* ------------ 問題5 年齢の降順で男性の名前と年齢を取得 ------------ */
  SELECT name,age FROM people 
    WHERE
      gender = 1
    ORDER BY 
      age DESC;

/* ------------ 問題6 テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL分を日本語で説明してください ------------ */
  SELECT
  `name`, `email`, `age`
  FROM
    `people`
  WHERE
    `department_id` = 1
  ORDER BY
    `created_at`;  

/*  peopleテーブルからname,email,ageの3つのカラムを取得
  department_idが1のみを取得する
  created_atで昇順にレコードを並び替える */

/* ------------ 問題7 20代の女性と40代の男性の名前一覧を取得してください。 ------------ */
  SELECT name FROM people
    WHERE
      (gender = 2 
        AND
      age BETWEEN 20 AND 29)
      OR
      (gender = 1
        AND
      age BETWEEN 30 AND 39);

/* ------------ 問題8 営業部に所属する人だけを年齢の昇順で取得してください。 ------------ */
SELECT p.* FROM people AS p 
  INNER JOIN
    departments AS d ON
    p.department_id = d.department_id
  WHERE
    d.name = '営業';

/* ------------ 問題9 開発部に所属している女性の平均年齢を取得してください。 
  カラム名はavarage_ageとなるようにしましょう ------------ */
SELECT AVG(p.age) AS avarage_age FROM people AS p 
  INNER JOIN
    departments AS d ON
    p.department_id = d.department_id
WHERE
  p.gender = 2
AND
  d.department_id = 2;

/* ------------ 問題10 名前と部署名とその人が提出した日報の内容を同時に取得してください
  (日報を提出していない人は含めない) ------------*/
SELECT p.name,d.name,r.content FROM people AS p
  INNER JOIN departments AS d ON 
    p.department_id = d.department_id
  LEFT OUTER JOIN reports AS r ON
    p.person_id = r.person_id
  WHERE
    r.content IS NOT NULL;

/* ------------ 問題11 日報を一つも提出していない人の名前一覧を取得してください ------------ */
SELECT p.name FROM people AS p
  LEFT OUTER JOIN reports AS r ON
    p.person_id = r.person_id
  WHERE 
    r.content IS NULL;

/* ------------ レビュー後指摘修正 ------------ */
/* ------------ department Table作成時のNOT NULL重複 ------------ */
/* .sqlは中身を記述されたsql構文を一気に実行するとのことで、重複されたテーブルでエラーが起きる可能性を考慮しコメントアウト */
 /*
 CREATE TABLE departments (
  depertment_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '部署ID',
  name VARCHAR(20) NOT NULL COMMENT '部署名',
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP COMMENT '作成日時',
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日時'
  );
*/
/* ------------ pepple Tableとdepartment Tableのdepertment_idのカラム名修正 ------------ */
/* 誤 depertment_id  正 department_id */
ALTER TABLE people RENAME COLUMN depertment_id TO department_id;
ALTER TABLE departments RENAME COLUMN depertment_id TO department_id;

/* ------------ departments Tableで自動で値が入るカラムは？ ------------ */
/* A.department_id, created_at, updated_at の３種類 */
/* department_id : AUTO_INCREMENTのオプションにより自動的に1から順繰りに挿入される */
/* created_at :  DEFFAULT のオプションにより、次に指定したTIME_STAMP(実行した日時)がデフォルト挿入される */
/* updated_at : created_atと同じくDEFFAULT のオプションにより、次に指定したTIME_STAMP(実行した日時)がデフォルトとして挿入される */
/*              また、ON UPDATE オプションにより、カラムに変更があった時に自動的にカラムを更新するように指定されている(中身は直後に指定しているTIME_STAMP) */


/* ------------ 予約後の大文字統一 ------------ */
/* VSCodeの置換機能により実行。置換したくないものまで巻き込まないよう注意
  例 : CREATE TABLE ~~とcreated_tableを一緒に置換してCREATEd_tableとならないように
 */

 /* ------------ INT型指定などの数値型はシングルクォーテーションで囲む必要なし ------------ */
 /* 修正 */

 /* ------------ 内部結合ではなく外部結合を使った理由 ------------ */
 /*
    例えば1人で複数の日報を提出していた場合、内部結合では1つのレポートしか取得できないのではと思い外部結合を選択
    実際に試したところ複数のレポートを取得できた為認識が間違っていたことを理解いたしました。
    内部結合では両テーブルと条件が一致するものだけを抜き出す。
    外部結合では基準となるテーブルを決めて、基準ではないテーブルにデータがない場合はNULLで表示される
    */
SELECT p.name,d.name,r.content FROM people AS p
INNER JOIN departments AS d ON 
  p.department_id = d.department_id
INNER JOIN reports AS r ON
  p.person_id = r.person_id;