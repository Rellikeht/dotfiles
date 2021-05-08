mkdir -p test_dir
cd test_dir
mkdir -p f1
mkdir -p f2

touch f1/p1
touch f1/p2
touch f1/.p1
touch f1/.p2

touch f1/p\*
touch f1/p.\*
touch f1/p.
touch f1/p[.]\*
touch f1/p|
touch f1/p1
touch f1/p2

touch f2/p.
touch f2/p[.]\*
touch f2/p|

touch f1/p\ *
touch f1/p\ 1
touch f2/p\ *
touch f2/p\ 1

touch f1/p\\*
touch f1/p\\1
touch f2/p\\*
touch f2/p\\1

touch f1/p\	*
touch f1/p\	1
touch f2/p\	*
touch f2/p\	1

touch f1/p\"*
touch f1/p\"1
touch f2/p\"*
touch f2/p\"1

for i in `seq 1 5`
do
	touch f2/p$i
	touch f2/.p$i
done

cd ..
