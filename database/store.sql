PGDMP     (        	            x            postgres    10.4    10.4 @    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            w           1262    13255    postgres    DATABASE     f   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE postgres;
             postgres    false            x           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                  postgres    false    3191                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            y           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    4                        2615    526256    store    SCHEMA        CREATE SCHEMA store;
    DROP SCHEMA store;
             postgres    false                        3079    13241    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            z           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    2                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                  false            {           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                       false    1            �            1255    526365 %   create_product_list(integer, integer)    FUNCTION     �  CREATE FUNCTION store.create_product_list(buyer_id integer, product_amount integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$  
declare  
    high integer := 88;
    low integer  := 24;
    product_random integer;
    buy_code varchar;
    pur_id integer ;
    product_price integer := 0;
    quantity integer;
    total_per_product integer;
    total integer  := 0;
    total_products integer := 0;
   response character varying;
  payment_day timestamp ;
  begin
	  SELECT floor(random() * 100000+ 1)::text into buy_code;
	 
	 select timestamp '2020-04-01 20:00:00' +
       random() * (timestamp '2020-05-02 20:00:00' -
                   timestamp '2020-03-01 10:00:00') into payment_day;
	 
	  INSERT INTO store.purchase
		(total_price, amount, credit_card, account_bank, bank_deposit, create_at, update_at, code)
		VALUES(0, 0, false, false, false, payment_day, null, buy_code) RETURNING id INTO pur_id;

	 FOR counter IN REVERSE product_amount..1 loop
	  select floor(random()* (high-low + 1) + low) into product_random;
	 
	  select price into product_price from store.products where id = product_random;
	  SELECT floor(random() * 4+ 1)::int into quantity;
	  total_per_product:= product_price * quantity;
	  total := total + total_per_product;
      total_products := total_products + quantity;
	 
	  INSERT INTO store.products_listing
		(products_id, buyers_id, purchase_id, create_at, update_at, quantity)
		VALUES(product_random, buyer_id, pur_id, (payment_day - interval '2 days'), null, quantity);
	
     END LOOP;
    
      response := 'update store.purchase set total_price = ' || total || ', amount = ' || total_products ||', credit_card = true, account_bank = true, bank_deposit = true where code = ''' || buy_code ||''' ;';
     raise notice 'total: %', total;
    raise notice 'total_products: %', total_products;
   raise notice 'buy_code: %', buy_code;
  raise notice 'response: %', response;
   
    return response;
     
  END;  
$$;
 S   DROP FUNCTION store.create_product_list(buyer_id integer, product_amount integer);
       store       postgres    false    2    5            �            1255    526364 8   create_product_list(integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION store.create_product_list(buyer_id integer, product_amount integer, inter_days character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$  
declare  
    high integer := 88;
    low integer  := 24;
    product_random integer;
    buy_code varchar;
    pur_id integer ;
    product_price integer := 0;
    quantity integer;
    total_per_product integer;
    total integer  := 0;
    total_products integer := 0;
   response character varying;
  payment_day timestamp ;
  begin
	  SELECT floor(random() * 100000+ 1)::text into buy_code;
	 
	 select timestamp '2020-04-01 20:00:00' +
       random() * (timestamp '2020-05-02 20:00:00' -
                   timestamp '2020-03-01 10:00:00') into payment_day;
	 
	  INSERT INTO store.purchase
		(total_price, amount, credit_card, account_bank, bank_deposit, create_at, update_at, code)
		VALUES(0, 0, false, false, false, payment_day, null, buy_code) RETURNING id INTO pur_id;

	 FOR counter IN REVERSE product_amount..1 loop
	  select floor(random()* (high-low + 1) + low) into product_random;
	 
	  select price into product_price from store.products where id = product_random;
	  SELECT floor(random() * 4+ 1)::int into quantity;
	  total_per_product:= product_price * quantity;
	  total := total + total_per_product;
      total_products := total_products + quantity;
	 
	  INSERT INTO store.products_listing
		(products_id, buyers_id, purchase_id, create_at, update_at, quantity)
		VALUES(product_random, buyer_id, pur_id, (payment_day - interval '2 days'), null, quantity);
	
     END LOOP;
    
      response := 'update store.purchase set total_price = ' || total || ', amount = ' || total_products ||', credit_card = true, account_bank = true, bank_deposit = true where code = ''' || buy_code ||''' ;';
     raise notice 'total: %', total;
    raise notice 'total_products: %', total_products;
   raise notice 'buy_code: %', buy_code;
  raise notice 'response: %', response;
   
    return response;
     
  END;  
$$;
 q   DROP FUNCTION store.create_product_list(buyer_id integer, product_amount integer, inter_days character varying);
       store       postgres    false    5    2            �            1259    526310    buyers    TABLE     S  CREATE TABLE store.buyers (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    age integer NOT NULL,
    address character varying(200) NOT NULL,
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone,
    country_id integer NOT NULL
);
    DROP TABLE store.buyers;
       store         postgres    false    5            �            1259    526308    buyers_id_seq    SEQUENCE     �   CREATE SEQUENCE store.buyers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE store.buyers_id_seq;
       store       postgres    false    5    203            |           0    0    buyers_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE store.buyers_id_seq OWNED BY store.buyers.id;
            store       postgres    false    202            �            1259    526373 	   countries    TABLE     �   CREATE TABLE store.countries (
    id integer NOT NULL,
    code character varying NOT NULL,
    name character varying NOT NULL
);
    DROP TABLE store.countries;
       store         postgres    false    5            �            1259    526371    country_id_seq    SEQUENCE     �   CREATE SEQUENCE store.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE store.country_id_seq;
       store       postgres    false    5    209            }           0    0    country_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE store.country_id_seq OWNED BY store.countries.id;
            store       postgres    false    208            �            1259    526292    products    TABLE     o  CREATE TABLE store.products (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    store_id bigint NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone
);
    DROP TABLE store.products;
       store         postgres    false    5            �            1259    526290    products_id_seq    SEQUENCE     �   CREATE SEQUENCE store.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE store.products_id_seq;
       store       postgres    false    201    5            ~           0    0    products_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE store.products_id_seq OWNED BY store.products.id;
            store       postgres    false    200            �            1259    526329    products_listing    TABLE       CREATE TABLE store.products_listing (
    id integer NOT NULL,
    products_id integer NOT NULL,
    purchase_id integer NOT NULL,
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone,
    quantity integer NOT NULL
);
 #   DROP TABLE store.products_listing;
       store         postgres    false    5            �            1259    526327    products_listing_id_seq    SEQUENCE     �   CREATE SEQUENCE store.products_listing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE store.products_listing_id_seq;
       store       postgres    false    207    5                       0    0    products_listing_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE store.products_listing_id_seq OWNED BY store.products_listing.id;
            store       postgres    false    206            �            1259    526321 	   purchases    TABLE     j  CREATE TABLE store.purchases (
    id integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    amount integer NOT NULL,
    credit_card boolean,
    account_bank boolean,
    bank_deposit boolean,
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone,
    code character varying(40),
    buyer_id integer NOT NULL
);
    DROP TABLE store.purchases;
       store         postgres    false    5            �            1259    526319    purchase_id_seq    SEQUENCE     �   CREATE SEQUENCE store.purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE store.purchase_id_seq;
       store       postgres    false    205    5            �           0    0    purchase_id_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE store.purchase_id_seq OWNED BY store.purchases.id;
            store       postgres    false    204            �            1259    526266    stores    TABLE     2  CREATE TABLE store.stores (
    id integer NOT NULL,
    code character varying(50) NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL,
    create_at timestamp without time zone NOT NULL,
    update_at timestamp without time zone,
    country_id integer NOT NULL
);
    DROP TABLE store.stores;
       store         postgres    false    5            �            1259    526264    store_id_seq    SEQUENCE     �   CREATE SEQUENCE store.store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE store.store_id_seq;
       store       postgres    false    5    199            �           0    0    store_id_seq    SEQUENCE OWNED BY     <   ALTER SEQUENCE store.store_id_seq OWNED BY store.stores.id;
            store       postgres    false    198            �           2604    526313 	   buyers id    DEFAULT     d   ALTER TABLE ONLY store.buyers ALTER COLUMN id SET DEFAULT nextval('store.buyers_id_seq'::regclass);
 7   ALTER TABLE store.buyers ALTER COLUMN id DROP DEFAULT;
       store       postgres    false    202    203    203            �           2604    526376    countries id    DEFAULT     h   ALTER TABLE ONLY store.countries ALTER COLUMN id SET DEFAULT nextval('store.country_id_seq'::regclass);
 :   ALTER TABLE store.countries ALTER COLUMN id DROP DEFAULT;
       store       postgres    false    208    209    209            �           2604    526295    products id    DEFAULT     h   ALTER TABLE ONLY store.products ALTER COLUMN id SET DEFAULT nextval('store.products_id_seq'::regclass);
 9   ALTER TABLE store.products ALTER COLUMN id DROP DEFAULT;
       store       postgres    false    201    200    201            �           2604    526332    products_listing id    DEFAULT     x   ALTER TABLE ONLY store.products_listing ALTER COLUMN id SET DEFAULT nextval('store.products_listing_id_seq'::regclass);
 A   ALTER TABLE store.products_listing ALTER COLUMN id DROP DEFAULT;
       store       postgres    false    207    206    207            �           2604    526324    purchases id    DEFAULT     i   ALTER TABLE ONLY store.purchases ALTER COLUMN id SET DEFAULT nextval('store.purchase_id_seq'::regclass);
 :   ALTER TABLE store.purchases ALTER COLUMN id DROP DEFAULT;
       store       postgres    false    205    204    205            �           2604    526269 	   stores id    DEFAULT     c   ALTER TABLE ONLY store.stores ALTER COLUMN id SET DEFAULT nextval('store.store_id_seq'::regclass);
 7   ALTER TABLE store.stores ALTER COLUMN id DROP DEFAULT;
       store       postgres    false    198    199    199            k          0    526310    buyers 
   TABLE DATA               `   COPY store.buyers (id, name, email, age, address, create_at, update_at, country_id) FROM stdin;
    store       postgres    false    203   �U       q          0    526373 	   countries 
   TABLE DATA               2   COPY store.countries (id, code, name) FROM stdin;
    store       postgres    false    209   +W       i          0    526292    products 
   TABLE DATA               l   COPY store.products (id, code, store_id, description, name, price, stock, create_at, update_at) FROM stdin;
    store       postgres    false    201   �X       o          0    526329    products_listing 
   TABLE DATA               g   COPY store.products_listing (id, products_id, purchase_id, create_at, update_at, quantity) FROM stdin;
    store       postgres    false    207   �a       m          0    526321 	   purchases 
   TABLE DATA               �   COPY store.purchases (id, total_price, amount, credit_card, account_bank, bank_deposit, create_at, update_at, code, buyer_id) FROM stdin;
    store       postgres    false    205   ^f       g          0    526266    stores 
   TABLE DATA               ^   COPY store.stores (id, code, description, name, create_at, update_at, country_id) FROM stdin;
    store       postgres    false    199   �i       �           0    0    buyers_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('store.buyers_id_seq', 12, true);
            store       postgres    false    202            �           0    0    country_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('store.country_id_seq', 34, true);
            store       postgres    false    208            �           0    0    products_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('store.products_id_seq', 88, true);
            store       postgres    false    200            �           0    0    products_listing_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('store.products_listing_id_seq', 208, true);
            store       postgres    false    206            �           0    0    purchase_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('store.purchase_id_seq', 58, true);
            store       postgres    false    204            �           0    0    store_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('store.store_id_seq', 11, true);
            store       postgres    false    198            �           2606    526318    buyers buyers_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY store.buyers
    ADD CONSTRAINT buyers_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY store.buyers DROP CONSTRAINT buyers_pkey;
       store         postgres    false    203            �           2606    526381    countries country_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY store.countries
    ADD CONSTRAINT country_pk PRIMARY KEY (id);
 =   ALTER TABLE ONLY store.countries DROP CONSTRAINT country_pk;
       store         postgres    false    209            �           2606    526302    products products_code_ukey 
   CONSTRAINT     U   ALTER TABLE ONLY store.products
    ADD CONSTRAINT products_code_ukey UNIQUE (code);
 D   ALTER TABLE ONLY store.products DROP CONSTRAINT products_code_ukey;
       store         postgres    false    201            �           2606    526300    products products_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY store.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY store.products DROP CONSTRAINT products_pkey;
       store         postgres    false    201            �           2606    526334 %   products_listing productslisting_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY store.products_listing
    ADD CONSTRAINT productslisting_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY store.products_listing DROP CONSTRAINT productslisting_pkey;
       store         postgres    false    207            �           2606    526326    purchases purchase_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY store.purchases
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY store.purchases DROP CONSTRAINT purchase_pkey;
       store         postgres    false    205            �           2606    526276    stores store_code_ukey 
   CONSTRAINT     P   ALTER TABLE ONLY store.stores
    ADD CONSTRAINT store_code_ukey UNIQUE (code);
 ?   ALTER TABLE ONLY store.stores DROP CONSTRAINT store_code_ukey;
       store         postgres    false    199            �           2606    526274    stores store_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY store.stores
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY store.stores DROP CONSTRAINT store_pkey;
       store         postgres    false    199            �           2606    526382    buyers buyers_fk    FK CONSTRAINT     t   ALTER TABLE ONLY store.buyers
    ADD CONSTRAINT buyers_fk FOREIGN KEY (country_id) REFERENCES store.countries(id);
 9   ALTER TABLE ONLY store.buyers DROP CONSTRAINT buyers_fk;
       store       postgres    false    209    3046    203            �           2606    526303    products products_store_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY store.products
    ADD CONSTRAINT products_store_id_fkey FOREIGN KEY (store_id) REFERENCES store.stores(id);
 H   ALTER TABLE ONLY store.products DROP CONSTRAINT products_store_id_fkey;
       store       postgres    false    201    199    3034            �           2606    526335 1   products_listing productslisting_products_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY store.products_listing
    ADD CONSTRAINT productslisting_products_id_fkey FOREIGN KEY (products_id) REFERENCES store.products(id);
 Z   ALTER TABLE ONLY store.products_listing DROP CONSTRAINT productslisting_products_id_fkey;
       store       postgres    false    3038    207    201            �           2606    526345 1   products_listing productslisting_purchase_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY store.products_listing
    ADD CONSTRAINT productslisting_purchase_id_fkey FOREIGN KEY (purchase_id) REFERENCES store.purchases(id);
 Z   ALTER TABLE ONLY store.products_listing DROP CONSTRAINT productslisting_purchase_id_fkey;
       store       postgres    false    3042    207    205            �           2606    526366    purchases purchase_fk    FK CONSTRAINT     t   ALTER TABLE ONLY store.purchases
    ADD CONSTRAINT purchase_fk FOREIGN KEY (buyer_id) REFERENCES store.buyers(id);
 >   ALTER TABLE ONLY store.purchases DROP CONSTRAINT purchase_fk;
       store       postgres    false    203    205    3040            �           2606    526392    stores stores_fk    FK CONSTRAINT     t   ALTER TABLE ONLY store.stores
    ADD CONSTRAINT stores_fk FOREIGN KEY (country_id) REFERENCES store.countries(id);
 9   ALTER TABLE ONLY store.stores DROP CONSTRAINT stores_fk;
       store       postgres    false    199    3046    209            k   ]  x���?o�0�����������!dH�,W���A����B %���Y�O���	h3�z��!�SI�׋Cc�.8�+h�Z�U�_xY���,Ɋ$+�(�*[u�R���� 2&ao�`q�-�>��ZqU��U���V,�/����<�˷����qs���\Y3��zԖ�؁C��e����@*V�Nk����D����2Od5�*+��~�%hk3i'Y��`,ߙ����B��$%[�Q�_�����u�b���D�;$jVC��A��� �*Γ̞�)�.2xCo���z�C�В	��I�nl�c����6����V{�4�MC?57�P���2�~��f      q   �  x�EQێ�0|_P��#8$�	�5R_�`e�\�j��{B��ɚ3#��9>�b���U?�^2��t@dZ��%!"+�t����]��- H&Lk�+閈E���dc,[aw���l?Z�7^:<�����w�Y��޽�Ӓ�m��?��]=&�#/.ȥ�w'��������ʺ@�,y���I[[�W��9>�z��TK-!�#��ZA\2B�N�/{��H)�0J��7�m ��]���Y���t�丏�){��+�/wm��q��pF�z�l?�Bx�}�Q09�N�>GR�H�5�$�-�7�ʁ�%��o��Ӧ��2�[��kS�#1S/�o�S���ut���"wʎ�°�GU�PQU����<Ie��NG%BT�~�\�F3�*	�e��ףj�r$�4��Dxgm���?�1�� 4��      i   �  x��Z�v��]���wIN"�~?��d���dk$yf�3�R�4 ڒ���,f5��K5)  �;^�`�{���V�L �5��i�z�Q�̣����7E������"q�C���(3������F���c
Sq@���ZQ�9���+&5���b�N�$�~�K�',\U�M�L��bV!���R��z6+_����NO0ӳTI2ݻ��?�iU�Y�
������'Ҫ1r1ΤP�K��ƕI���O�̕�s�o�B�N&E��U��Sn��W��������U�k�B�1���*�g�羨b|v�ǧ$��p�x��o���}�D���dԨ-2Zrɩ�R�{6/�҃��EZ%�E%>w)~;ǜJ|�� ��J�CO|\���r+I�_�0�7������L�6�+��g.��E/KՄ��v��u��o���YX�_���b�G�$ΓE�) ܆����	֌��S�g��Ȩ��É��.+�3�O�	>-��r���K��ų£�<+��R+a,!Zv�]��4����ۻ0���f�ڿ�����9�'����^UyK�y���XTm�Ƨ��Ӌ���S.?�u�Q�3W%�z�=�EA�s:�)M�$
6r7�%Q�����YĹ��4P�d�&�}�_$9�'�b���M��ܣ�������M�	Z�-W=��p�&�)�|�/�خ8؝�������1t,_p�,���s���$M�JZ:or��|�5�SP�����ksF/{{��Wq+Ǧ`��T���_��B��p���H��<�'�w~z�=�q!�i���1A�N~~p�����f����*����B�y�4���e�����6���*ŭ��ԥ����y��}�Ϫk�b�>	u��s ?'H�z�;��9�%E�	��WA��@龕;2�����%�U ��q{ab�wU�U,�P{(��C����"K�ģ�)h�iF�Zpd��P��^�����8O��U�|��_�ܹ�>�×�쳻�oJ�M����/Rcu��^��Х0���[Q�S�M�%�v�nq���4���\�ܰ~I���|t����j­���7�[�����emŊ�2\�O@!���l�u-h��bQ���8�1�[M���v�eb(�c�����*<T��"E��M�m"����F��Y�f�a�  E��b�,)ä.�,d�HU��GYS��:�.�E�X�g=��4��bN\�:?��1�nfE�0��JC+����8ri�ګ�gY�'Æ)ȟVFk�:����o]�)���&�s�i�xq�#Y�C׽��d�*���E?-��![cQBw.��� y��:������xYZW{�Y���(ѵ~�"�4�ѣ�)���!���R�2|pI|
!��j���#TME������:[Kj����.��Z�!��B���>5�S�c�[����X���FΠ72��d����
��<VFx't�<�����3	��1E��O�1Z�4m;�F�����9����eg�v���3f�"h��um7j����n���P�P��N���)��Ճ�PdY ����l#4[�iEƠ9�
��+4��[h�|p�-���O�.�B��Т�f��ݍ�� �
�����r�I\@�����:8D�{��13B� �kz~dxC��t�!03z�u^�+ �x4<�ڐc�T5�jL�B�q(���0ֺ3|"�jL���Dn-;îDC��i\��$� 	:x�R(����a��FZ(��Ǡ �1�-��`X3|���$����L�Q0(;��Yi�[�U~^� �_7��I��.=�AT� ����2y�h��1�1�`ZX�d ��w8��M5o��n��J���]���dHcZ{��!��Oh��|�%H�Uz���q0��$)��JF���i�)���n��N��6�,c	U���
ni���;頣δ�F�:�}��~�Tqt��,%&pl�\�1_���1�e7���4�� iF�����7�P��Y�ɧ2`�F��~۞Սm����C7����o������q������!��E{�?�M�F�>����ɉP�̨1�-W�q��H�}Ty(�Np�����aۦm�ԁ����v[ ��
a-�݌�&�^�����f�b��"�O������A��èz
z�㵃S�Ȁ�Cj��w=����-�����c����=�a��6Û��!����z��9[\�      o   �  x���˱�0E��(:��B|r���\��v�JTyy
��9�j,�������4;U	s���Ư�%P^�ͽ�~�>�g���14B�_!�F	Ԇ��.�~��YN�S�F�|���nA�q4��͸����ob�|�~xv�'g�e��q��b�w�m�=��Iͬ��r�Df`1>g΀kO�mN��@iC�����s��l<�;μ�����J���8B��7�=ȯMG㎳I��NH�TLv4�R�/@t�y*.6�u�N�D���$�͋d;���ݧK�qK�Mm�{R@ZzT:}45���S�}$�]���S�A�U?QB��=	��V<��J��O��~�;����lIx�W0K�,����B�s�]�u٬����%ӣ���#��)2%���#�w�ț؇�R&�$?����d�֔�$A]�\1ћD�
$����'�;�mIx��AP�i��*�U���4-�D�
�L�s�����8�7�G!����5
$|Gc�lrQ���u��+GdՉ��I�mB�ӛ��it��C �i9������sˏ1�����,��FcO����O�U�`S�VZ��|v�)CH�ޕ	�/��Ij�]E����@mJ$�8����ܓ�]W��$jI�*W:Z��dF)R���yl}&�iq8���#ȗK�4jXOK$��X���� Qɘq��4��>��u�(-S�2����m�KnID	��UK6-u�dsd�o��hmu�(r��6��u�:{�9��KCl�b�#>f��^�D�A�$l��@�#���k$�(��sH
ݖD���WNO��z�B�U��֛��X=�K���~(M���G�Z�#aө9�Ix����$<r^�Y!%�a�t]���9��zb
�}�7U\2UqG���|���4��А`�{W� �Е�(�\/W�.��<&,ޙ#ٝ͠��-	�c	��x]�y�[z�P�
z��{�ə���v����������B�'���g�{��ӝ�XRX"#7*��j���U	��,�s=V�T�I93�-���*G@����\�%�{�XX��צ����H5=�4�D�=��5�Z��$�v�q�>5떄 ��ޒ(�9�֖L�<G[鞱ʭr���P��i�1(ܓ��[�d��]�)����?�_�V�I��g��
i)�[2�I�\�\��ȱ^ ����T��v      m   i  x�uV�q\1;KUl��+R*"�
���~�~v<��3X�  �h3��AԼ�i�'$�A���vߦCӃ����$'e�.���C��Qn�MsL˴��w������n��>���v��l��l��#�Ⱥ�`��<"�M/h�Tk,]���<�LW�!&�>��S�!� i g[�?��j_��ג�#U�b\,��͙Ob�+���<�hR�"�Zt%���s���MF��XɎ�X]!6��'��0�MZ|�ۑ��'����t>7����yE�� a��ly6���\�>�.웵�F��1Rf�ccu�?p-�)�r}c�2A�������\�]���Nv�2xk�M1�W��d�>�w�n$����K&��ȉ���uv�6��zGBh��܊D$�J���{e�lg�ǅ�B�	�ZV�8�H�ɋu���#��";m�1#���.�g�� m�3�,��sf)s��c�5�n�U��/o�(��g�,�Jbe;B�[Ű�����+��U}JN?c�M�׺� K�]�Ό -��!��9C���fM�I����X�s�uR��(����ϵ^b]7)��B��`�{U(����V�e�}_�U�%�԰4�ٷ�w��_�^�;ŉ� �� �[i�Dֳj9��sd���h)�_�

R���!.��Ua��Ҋ��#\1�c�0~�㻧cci���t6v��];�����5�x�V�%=���x!�Q�v9������$����>F�&G�0�����,�b+o��W͠u�������|��7��bt zG�3�?��atw`y�:���R�[x��=�q
�7�Wg�{�4��p\��Y��</� σG�g͊^x)̓�]y���M���G�<�t�yջ����r�]h�q���G��<��      g   �   x�}�M
�0����@df�N�n���$ԠM�z��
q��m>ð�Jq�v1���!�KL��e���ح�P�12,�&n�[θ,jد���K("��n���`�Ѳ����b��JP�ͬyw�y�Ô�Tb�.�D�/ʡKF-�Sl���cF?��(4!�:�6>�K���-�j?SJ=�7f�     