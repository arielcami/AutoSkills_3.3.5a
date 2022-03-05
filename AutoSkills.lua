--[[
	Ariel Camilo // ariel.cami@gmail.com // 4 de Marzo 2022.

	Este script esta diseñado para trabajar con servidores 3.3.5a de rates bajos, preferiblemente 1x.

	Este script no solo va enseñando habilidades, sino que completa las CADENAS DE MISIONES importantes 
	que necesitan clases como el Druida para su forma de oso, el Brujo para sus demonios y 
	el Cazador para poder domesticar una bestia. De esta manera, dichas misiones quedan registradas en el server
	y no sucede como pasa con otros scritps que solo enseñan el hechizo 
	y dejan la misión para que el jugador las haga y aprenda el mismo hechizo otra vez.

	Si se usa en servidores con experiencia alta, puede que se obvien habilidades, 
	como ejemplo, si un jugador entrega una misión que le sube del nivel 13 al 15,
	las habilidades que correspondan al nivel 14 NO SE APRENDERÁN. 

	Este script añade automáticamente los hechizos que enseña el entrenador, de acuerdo al nivel del jugador.
	El jugador debe acercarse a su entrenador para aprender nuevos rangos de los hechizos
	obtenidos a través de los talentos.

	Este script funciona perfectamente para servidores donde hay leveleo del 1 al 80. 
	Si se emplea este script en un servidor donde se empiece por ejemplo nivel 60, las habilidades 
	de niveles anteriores se deben entrenar manualmente en el entrenador. 

	PD: Fueron muchos días de arduo trabajo y testeo, te agradecería muchísimo una estrellita y un follow. Gracias!
]]

local SKILLS, MISIONES_4, MISIONES_10, MISIONES_12, MISIONES_20, MISIONES_30, PORT_MAGO_20, PORT_MAGO_40 = {--> Skills. Estructura: Clase > Id de Skills
[1] = {--Guerrero
	{},{},{},{100,772},{},{3127,6343,34428},{},{284,1715},{},{6546,2687},{},{7384,5242,72},{},{1160,6572},{},{694,285,2565},{},{8198,676},{},
	{6547,20230,845,12678,674},{},{6192,5246},{},{1608,5308,6190,6574},{},{6178,1161},{},{8204,871},{},{6548,1464,20252,7369},{},{11564,20658,11549,18499},
	{},{11554,7379},{},{1680},{},{8205,8820,6552},{},{11572,11565,20660,11608,23922,750},{},{11550},{},{11555,11600},{},{11578,11604},{},{11580,11566,20661,23923},
	{},{11573,11609,1719},{},{11551},{},{11605,11556,23924,11601},{},{11567,20662},{},{11581},{},{11574,25286,25289,20569,23925,25288},{25241},{25202},{25269},
	{23920},{25234},{29707,25258},{25264},{25208,469,25231},{25242,2048},{30324,25236,25203,30356,3411,30357},{46845,64382},{47449,47519},{47501,47470},{47474,47439},
	{55694,47487},{47465,47450},{47520},{47502,47436},{47475,47437},{57755,47471,47440,47488,57823}},
[2] = {--Paladín
	{},{},{},{19740,20271},{},{498,639},{},{3127,853,1152},{},{10290,1022,633},{},{19834,53408},{},{31789,19742,647},{},{25780,62124,7294},{},{1044},{},
	{20217,5502,643,26573,19750,879},{},{20164,19835,19746,1026},{},{5599,10326,19850,10322,5588},{},{1038,10298,19939},{},{19876,53407,5614},{},
	{10291,19752,20116,2800,1042,20165},{},{19888,19836},{},{642,19852,19940},{},{19891,10299,5615,10324},{},{10278,3472,20166},{},{750,1032,19895,5589,20922},{},
	{19837,19941,4987},{},{19897,24275,19853,10312},{},{6940,10300,10328},{},{19899,20772},{},{10292,2812,20923,19942,10310},{},{19896,19838,25782,24274,10313},
	{},{10308,19854,25894,10329},{},{19898,10301},{},{19943},{},{10293,19900,25898,25291,25916,24239,25290,25918,10318,20924,10314,25292,20773},{},{32223,27135},
	{27151},{},{27142,27143},{27150,27137},{},{27152,27180,27138},{27139,27154},{27149,27153,27140,27141,31884,27173,27136},{48935,48937,54428},{48816,48949},
	{48931,48933,48800},{48941,48805,48784},{53600,48818,48781},{48943,54043},{48945,48936,48938},{48947,48817,48788},{48942,48932,48934,48785,48801,48950},
	{61411,48806,48819,53601,48782}},
[4] = {--Cazador
	{},{1494},{},{13163,1978},{},{3044,1130},{},{5116,14260,3127},{},{13165,13549,19883},{},{136,14281,20736,2974},{},{1513,1002,6197},{},{5118,14261,1495,13795},
	{},{14318,2643,13550,19884},{},{674,3111,34074,14282,1499,781},{},{14323,3043},{},{1462,14262,19885},{},{3045,13551,19880,14302},{},{3661,14319,14283,13809},{},
	{13161,14326,14288,5384,14269},{},{1543,14263,19878},{},{13552,13813},{},{3662,14284,3034,14303},{},{14320},{},{8737,13159,14324,1510,14264,19882,14310},{},
	{14289,13553},{},{13542,14285,14270,14316},{},{20043,14327,14304},{},{14321,14265},{},{56641,13554,14294,19879},{},{13543,14286},{},{14290,14317},{},
	{20190,14266,14305},{},{14322,14325,13555,14295,14271},{},{13544,25296,14287,19801,25294,25295,19263,14311},{27025},{34120},{27014},{},{27023},{34026},
	{27021,27016,27022},{27046,27044,27045,34600},{27019},{36916,34477},{49051,53351,48995,49066},{49055},{49044,49000},{48989,61846,49047,58431},{53271,61005},
	{49071,53338},{49052,48996,49067},{49056},{49045,49001},{48990,61847,62757,61006,49048,58434,60192,53339}},
[8] = {--Pícaro
	{},{},{},{53,921},{},{1757,1776},{},{6760,5277},{},{5171,2983,6770},{},{1766,2589,3127},{},{8647,703,1758},{},{6761,1966,1804},{},{8676},{},{51722,1943,2590},{},
	{8631,1759,1725,1856},{},{6762,2836},{},{8724,1833},{},{8639,2591,6768,2070},{},{8632,408,1760,1842},{},{8623},{},{8725,8696,2094},{},{8640,8721},{},{8633,8621},{},
	{8624,8637,1860},{},{11267,6774,1857},{},{11273,11279},{},{11289,11293},{},{11299,11297},{},{11268,8643,26669},{},{11274,11303,11280},{},{11290,11294},{},{11300},
	{},{11269,11305},{},{11281,31016,11275,25302,25300},{26839},{32645,26861,26889},{},{26865,26679,27448},{},{27441,31224},{},{26867,26863},
	{32684},{48689,26884,48673,26862,5938},{51724},{48658},{48667},{57992,48671,48656},{48690,48675,57934},{48674,48637},{},{48659},{48668,48672},
	{48691,57993,48676,51723,48638,48657}},
[16] = {--Sacerdote
	{},{},{},{589,2052},{},{17,591},{},{586,139},{},{8092,594,2006,2053},{},{588,1244,592},{},{8122,528,598,6074},{},{8102,2054},{},{527,600,970},{},
	{9484,7128,6346,453,2944,14914,15237,6075,2061},{},{8103,2096,984,2010,2055},{},{1245,3747,8129,15262},{},{992,6076,9472},{},{8124,8104,19276,15430,6063},{},
	{14752,602,6065,605,976,15263,1004,596},{},{6077,9473,552},{},{1706,8105,6064,10880,2767},{},{988,2791,6066,19277,15264,15431},{},{6060,6078,9474},{},
	{9485,14818,1006,8106,996,2060},{},{10898,10888,10892,10957,15265},{},{19278,10909,27799,10927,10915},{},{10945,10933,10881,10963},{},{10937,10899,21562,15266},
	{},{14819,10951,10893,10928,10960,10916},{},{10946,19279,27800,10964},{},{10900,15267,10934},{},{10890,10958,27683,10929,10917},{},{10947,10894,20770,10965},{},
	{10955,27841,10952,10938,10901,21564,27681,19280,15261,27801,25315,10961,25314,25316},{25363,25233},{32379},{25372,25210},{32546},{25217,25367,25221},{34433,25384},
	{25235},{25467,25433,25331,25435,33076,25308,25213},{25431,25375,25364},{32375,25312,25389,25218,25392,32999,25368,32996,39374,25222},{48040},{48134,48119},
	{48299,48070,48062},{48126,48122,48112},{48065,48045,48124,48157,48077,48067},{48169,48072},{48168,48170},{48135,48171,48120,48063},{48127,48300,48123,48113,48071},
	{48073,48161,48066,48162,48074,53023,48125,48158,64901,64843,48078,48068}},
[32] = {--Caballero de la Muerte
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
	{},{49998,46584,50842},{47528,48263,53342,54447},{45524,48721},{47476,49926},{53331,49917,43265},{49020,3714,49896},{48792,49892},{53323,54446,49999},{49927,45529},
	{57330,49918,56222},{49939,48743},{51423,49903,56815,49936},{48707,49893},{49928},{53344,49919,45463,48265},{},{62158,70164,61999,49940},{51424,49904,49937},{49929},
	{57623,47568,49920,49923},{49894},{},{49909,49941},{51425},{42650,49895,49921,49924,49938,49930}},
[64] = {--Chamán
	{},{},{},{8042},{},{2484,332},{},{8044,529,5730,8018,324},{},{8050,8024,8075},{},{1535,370,2008,547},{},{8045,548,8154},{},{57994,8019,325,2645,526},{},
	{8052,6390,8027,913,8143},{},{8056,915,6363,8033,52127,8004},{},{8498,131},{},{8046,10399,905,8181,8160,8155,20609,939},{},{943,8190,8030,6196,5675},{},
	{8053,6391,8038,546,8184,8227,52129,8008},{},{66842,6364,8232,556,10595,8177,51730,20608,36936,6375},{},{421,6041,8499,8012,945,8512,959},{},
	{8058,6495,10406,52131},{},{10412,10585,16339,20610,8010,10495},{},{10391,6392,10456,10478,8161,8249,8170},{},
	{930,10447,66843,6365,8235,8134,51988,8005,1064,6377,8737},{52134},{11314,10537},{},{10392,10600,10407,10466},{},{10472,10586,16341,10622,10496},
	{},{2860,10413,10427,16355,10431,10526,52136,20776,10395},{},{15207,66844,10437,10486,51991,10462},{},{10448,11315,10442,10467},{},{10479,10408,10623},{52138},
	{10605,15208,10587,16342,10432,10396,10497},{},{10473,10428,16356,10538,16387},{},{29228,10414,10438,16362,10601,25361,51992,20777,25357,10468,10463},
	{25546,25422},{25448,24398},{25439,25469,25508,25391},{25489,3738},{25552,25528,25570},{25500,2062,25420},{25449,25525,25560,25557},{25464,2894,25505,25563,25423},
	{25454,25533,25574,33736,25590,25567},{25442,25457,25547,25472,25509,51993,25396},{58699,58580,58794,58785,58801,58649,58755,58771},
	{49275},{49235,49237,58731,58751},{49270,49230,55458},{49232,61649,51505,58703,58581,49280,58741,58746,58737,57622,58652,49272},{58795,58789,58803,57960,58756,58773},
	{49276},{49236,58734,58582,58753},{49231,49238},
	{49271,49233,51514,61657,60043,58704,58796,58790,58804,49281,58745,58749,58745,58643,58656,51994,49277,49273,55459,58757,58774,58739}},
[128] = {--Mago
	{},{},{},{5504,116},{},{587,143,2136},{},{5143,118,205},{},{5505,7300,122},{},{604,145,597,130},{},{1449,1460,837,2137},{},{5144,2120},{},{1008,475,3140},{},
	{5506,1463,12051,12824,1953,7301,7322,10,543},{},{990,8437,6143,2948,2138},{},{8450,2139,5145,8400,2121},{},{120,8406,865},{},{759,8494,1461,6141,8444},{},
	{8455,6127,8438,7302,45438,8401,8412,8457},{},{6129,8416,8407,8461,8422},{},{6117,8492,8445},{},{8451,8495,8427,8402},{},{3552,8439,8408,8413},{},
	{10138,8417,12825,7320,6131,8446,8423,8458},{},{10169,10144,10156,10159,8462,10148},{},{10191,10179,10185},{},{22782,10201,10205,10197},{},
	{10173,10053,10211,10149,10215},{},{10139,10219,10160,10180,10223},{},{10145,10192,10177,10186,10206},{},{10170,10202,10230,10150,10199},{},
	{10157,23028,10212,10181,10216},{},{22783,10054,10161,10207},{},{10174,10140,28612,10193,25345,12826,10220,25304,28609,10187,10151,10225},{27078},{27080,30482,25306},
	{27130,27075,27071},{30451,27086},{37420,27087,27073},{30455,27070},{33944,27088},{27101,27131,66,27085},{33946,27125,38699,27124,27072,27128},
	{27090,33717,27082,27126,27127,38704,43987,30449,38697,32796,27074,38692,27079},{43023,42894,43045,53140},{42930,42913,42925},{43019,42858},{42939,42832,42872,53142},
	{42955,42843,42841,42917,44614},{43015,42920,42896},{43017,42985},{42914,42859,42833,43010},{42931,42842,43012,43046,42926,43024,43020,42846,43008},
	{42956,42921,42897,42995,43002,55342,58659,42940,47610,42873}},
[256] = {--Brujo
	{},{},{348},{172,702},{},{1454,695},{},{980,5782},{},{1120,6201,696,707},{},{1108,755,705},{},{6222,689},{},{1455,5697},{},{1014,5676,693},{},
	{706,3698,698,1088,1094,5740},{},{699,6205,6202,126},{},{6223,5138,5500,8288},{},{1714,1456,132,17919},{},{6217,3699,6366,710,1106},{},
	{709,1086,20752,1098,2941,1949},{},{7646,1490,6213,6229},{},{7648,5699,17920,6219},{},{11687,3700,17951,2362,7641},{},{7651,11711,8289},{},
	{5484,11733,20755,11665},{},{6789,11707,11739,17921,11683},{},{11671,11693,11725,11659},{},{11699,11721,11688,17952,11729,11677},{},{11712,17727,18647,6353},
	{},{17925,11719,11734,20756,17922,11667},{},{11675,11708,11694,11740,11660},{},{17928,11672,11700,11684},{},{6215,11689,17953,17924},{},
	{17926,11713,11730,11726,17923,11678},{},{25311,603,11722,11735,11695,20757,17728,28610,11661,11668,25309},{27224},{27219,28176,25307},{},{27211,29722},
	{27216,27210},{27250,28172,29858},{27218,27259,27217},{27223,27222,27230,29893,27213},{27220,30909,27228,28189,27209,27215,27212},
	{30910,27243,27260,27238,30459,30545,32231},{47812,50511},{47886,61191,47890,47819},{47859,47863,47871},{47892,60219,47808,47814,47837},{47835,47824,47810,47897},
	{47793,47856,47884},{47813,47855},{47857,47860,47865,47888,47891,47823},{47864,47893,47878,47809,47815,47820},
	{47867,47836,57946,47889,48018,48020,60220,58887,47825,47838,47811,61290}},
[1024] = {--Druida
	{},{},{},{8921,774},{},{5177,467},{},{339,5186},{},{8924,16689,5232,1058,99,18960},{},{8936,50769,5229},{},{5178,5211,782,5187,8946},{},{779,1430,8925,783,1066},{},
	{16857,8938,6808,770,2637,1062,16810},{},{768,1735,2912,6756,5188,5215,1079,1082,20484},{},{5221,2908,5179,8926,2090},{},{1822,780,5217,1075,2782,8939,50768},
	{},{1850,6809,8949,2893,5189},{},{8998,9492,5209,3029,8927,5195,2091,16811},{},{6798,6800,5180,5234,8940,740,20739},{},{6785,22568,5225,9490,6778},{},
	{8928,8950,8914,8972,769,1823,3627},{},{9005,9493,6793,22842,8941,50767},{},{8992,5201,8955,6780,18657,5196,8903,16812},{},
	{9000,62600,9634,20719,22827,29166,8929,16914,8907,8910,20742,8918},{},{6787,9745,9747,8951,9750},{},{1824,9752,9754,9756,22812,9758},{},
	{9823,8983,9821,9829,8905,9833,9839},{},{9845,22828,9849,9852,9856,50766,16813},{},{9866,9880,9875,17401,21849,9884,20747,9888,9862},{},{9892,9894,9834,9898,9840},
	{},{9904,9908,9830,9901,9912,9910,9857},{},{9827,22829,9889},{},{9867,9881,9850,9835,9876,18658,9853,9841,17329},{},
	{31709,9896,9846,31018,25298,17402,21850,9885,9858,25299,20748,50765,25297,9863},{27001,26984},{22570,26998,26978},{24248,26987,26981},{27003,26997,26992,33763},
	{33357,26980},{27006,27005,33745},{27008,26996,27000,26986},{26989,27009},{27004,26985,26982,26994,50764,26979},{27002,26995,33786,26988,27012,26991,26990,26983},
	{49799,62078,50212,48559,48442},{48573,48561,48576,48464,48450},{48578,48567,48479,48569},{49802,48459,53307,48377},{52610,48571,48462,48440,48446},{48575},
	{49803,48562,48560,48443},{48574,48577,48465,53308,53312},{48579,50213,48480,48570,48461,48477,48378},
	{49800,48568,48572,48463,48467,48470,48451,48469,50464,48441,50763,48447}}},
--> Misiones. Estructura: Clase > Raza > Id de Misión.
{[64] = {--Misiones de Chamán - Tótem de Tierra - Nivel 4
	[2] = 	{1516,1517,1518},
	[32] = 	{1519,1520,1521},
	[128] = {1516,1517,1518},
	[1024] ={9449,9450,9451}}},
{[1] = {--Misiones de Guerrero, - Actitud defensiva - Nivel 10
	[1] = {1638,1639,1640,1665},
	[2] = {1505,1498},
	[4] = {1638,1639,1640,1665},
	[8] = {1638,1639,1640,1665},
	[16] = {1818,1819},
	[32] = {1505,1498},
	[64] = {1638,1639,1640,1665},
	[128] = {1505,1498},
	[1024] = {1638,1639,1640,1665}},
[4] = {--Misiones de Cazador - Domesticar bestia - Nivel 10
	[2] = {6070,6062,6083,6082},
	[8] = {6063,6101,6102,6103},
	[32] = {6061,6087,6088,6089},
	[128] = {6070,6062,6083,6082},
	[512] = {9484,9486,9485,9673},
	[1024] = {9757,9591,9592,9593,9675}},
[64] = {--Misiones de Chamán - Tótem de fuego - Nivel 10
	[2] = 	{1524,1525,1526,1527},
	[32] = 	{2958,1524,1525,1526,1527},
	[128] = {1524,1525,1526,1527},
	[1024] ={9464,9465,9467,9468,9461,9555}},
[256]= {--Misiones de Brujo - Abisario - Nivel 10
	[1] = {1685,1688,1689},
	[2] = {1501,1504},
	[16] = {1473,1471},
	[64] = {1715,1688,1689},
	[512] = {9529,9619}},
[1024]= {-- Misiones de Druida - Forma de Oso - Nivel 10
	[8] = {5923,5921,5929,5931,6001},
	[32] = {5922,5930,5932,6002}}},
{[2] = {-- Misiones de Paladín - Redención - Nivel 12
	[1] = {1642,1643,1644,1780,1781,1786,1787,1788},
	[4] = {3000,1646,1647,1648,1778,1779,1783,1784,1785},
	[512] = {9677,9678,9681,9684,9685},
	[1024] = {9598,9600}}},
{[64] = {-- Misiones de Chamán - Tótem de agua - Nivel 20
	[2] = {1528,1530,1535,1536,1534,220,63,100,96},
	[32] = {1529,1530,1535,1536,1534,220,63,100,96},
	[128] = {1528,1530,1535,1536,1534,220,63,100,96},
	[1024] = {9501,9503,9504,9508,9509}},
[256] = {--Misiones de Brujo - Súcubo - Nivel 20
	[1] = {1717,1716,1738,1739},
	[2] = {1507,1508,1509,1510,1511,1515,1512,1513},
	[16] = {1472,1476,1474},
	[64] = {1717,1716,1738,1739},
	[512] = {10605,1472,1476,1474}}},
{[1] = {--Misiones de Guerrero, - Actitud rabiosa - Nivel 30
	[1] = {1718,1719},
	[2] = {1718,1719},
	[4] = {1718,1719},
	[8] = {1718,1719},
	[16] = {1718,1719},
	[32] = {1718,1719},
	[64] = {1718,1719},
	[128] = {1718,1719},
	[128] = {1718,1719},
	[1024] = {1718,1719}},
[64] = {-- Misiones de Chamán - Tótem de fuego - Nivel 30
	[2] = {1531},
	[32] = {1532},
	[128] = {1531},
	[1024] = {9552,9553,9554}},
[256] = {--Misiones de Brujo - Manáfago - Nivel 30
	[1] = {1798,1758,1802,1804,1795},
	[2] = {2996,1801,1803,1805,1795},
	[16] = {3001,1801,1803,1805,1795},
	[64] = {1798,1758,1802,1804,1795},
	[512] = {3001,1801,1803,1805,1795}}},
--> Teletransportes y Portales. Estructura: Clase > Id de Skill
{[1] = {3561,3565,32271,3562}, --Teletransportes del Mago - Nivel 20
	[16] = {3567,32272,3566,3563},
	[64] = {3561,3565,32271,3562},
	[128] = {3567,32272,3566,3563},
	[512] = {3567,32272,3566,3563},
	[1024] = {3561,3565,32271,3562}},
{[1] = {10059, 11419, 32266, 11416}, --Portales del Mago - Nivel 40
	[16] = {11417,32267,11420,11418},
	[64] = {10059, 11419, 32266, 11416},
	[128] = {11417,32267,11420,11418},
	[512] = {11417,32267,11420,11418},
	[1024] = {10059,11419,32266,11416}}

local function CambioDeNivel(evento, P, N)
local L, R, C, A, H, money = P:GetLevel(), P:GetRaceMask(), P:GetClassMask(), P:IsAlliance(), P:IsHorde(), P:GetCoinage()
local humano,orco,enano,elfo_a,nomuerto,tauren,gnomo,trol,elfo_h,draenei = (R==1),(R==2),(R==4),(R==8),(R==16),(R==32),(R==64),(R==128),(R==512),(R==1024)
local guer,pala,caza,pica,sace,dk,cham,mago,bruj,drui = (C==1),(C==2),(C==4),(C==8),(C==16),(C==32),(C==64),(C==128),(C==256),(C==1024)
local L20,L40,L60,L70,L77 = (L==20),(L==40),(L==60),(L==70),(L==77)
local RepH,RepA = P:GetReputation(76), P:GetReputation(72)
local Compl,Complet,Def = '|cfff2b141Has completado la misión de ','|cfff2b141Has completado la cadena de misiones para ','|cff6ddbf9[Actitud devensiva]|cfff2b141.'
local Bersk,Reden,sucu,abis = '|cff6ddbf9[Actitud rabiosa]|cfff2b141.','|cff6ddbf9[Redención]|cfff2b141.','|cff6ddbf9[Invocar súcubo]|cfff2b141.','|cff6ddbf9[Invocar abisario]|cfff2b141.'
local tier,fueg,agua = '|cff6ddbf9[Tótem de tierra]|cfff2b141.','|cff6ddbf9[Tótem de fuego]|cfff2b141.','|cff6ddbf9[Tótem de agua]|cfff2b141.'
local aire = '|cfff2b141Recibes |cffffffff[Tótem del Anillo de la Tierra]|cfff2b141 por haber completado todas las misiones y tener los 4 Tótems.'
local mana,oso = '|cff6ddbf9[Invocar manáfago]|cfff2b141.','|cff6ddbf9[Forma de oso]|cfff2b141.'
local caz1 = '|cff6ddbf9[Domesticar bestia]|cfff2b141.'
-------------------------------------------------------------------------------------------------------------------------------------------
	function QUEST(Q) P:AddQuest(Q) P:CompleteQuest(Q) P:RewardQuest(Q)	end -- Método para completar misiones por ID.
-------------------------------------------------------------------------------------------------------------------------------------------
	function AUTOSKILL_(clase, nivel) 
	for i = 1, #SKILLS[clase][nivel] do P:LearnSpell(SKILLS[clase][nivel][i]) end end -- Bucle lector de tabla SKILLS.
-------------------------------------------------------------------------------------------------------------------------------------------
	function PORTALES(p) P:LearnSpell(p) end    function D(id) P:RemoveItem(id,1) end                   AUTOSKILL_(C,L)  -- Bucle principal
-------------------------------------------------------------------------------------------------------------------------------------------
-- Skills Específicas de Bando.
	if pala and L==66 and H then P:LearnSpell(53736) end
	if pala and L==64 and A then P:LearnSpell(31801) end
	if mago and L==60 then if H then P:LearnSpell(tel_shat_H) else P:LearnSpell(tel_shat_A) end end
	if mago and L==65 then if H then P:LearnSpell(por_shat_H) else P:LearnSpell(por_shat_A) end end
	if cham and L==70 then if H then P:LearnSpell(2825) else P:LearnSpell(32182) end end
----Gestor de misiones y Teletransportes del Mago------------------------------------------------------------------------------------------
		if cham and L== 4 then for i=1,  #MISIONES_4[C][R] do QUEST( MISIONES_4[C][R][i]) end
	elseif cham and L==10 then for i=1, #MISIONES_10[C][R] do QUEST(MISIONES_10[C][R][i]) end
	elseif guer and L==10 then for i=1, #MISIONES_10[C][R] do QUEST(MISIONES_10[C][R][i]) end	
	elseif caza and L==10 then for i=1, #MISIONES_10[C][R] do QUEST(MISIONES_10[C][R][i]) end
	elseif bruj and L==10 then for i=1, #MISIONES_10[C][R] do QUEST(MISIONES_10[C][R][i]) end
	elseif drui and L==10 then P:SendAreaTriggerMessage(Complet..oso) for i=1, #MISIONES_10[C][R] do QUEST(MISIONES_10[C][R][i]) end
	elseif pala and L==12 then for i=1, #MISIONES_12[C][R] do QUEST(MISIONES_12[C][R][i]) end
	elseif mago and L==20 then for i=1, #PORT_MAGO_20[R]  do PORTALES(PORT_MAGO_20[R][i]) end
	elseif cham and L==20 then for i=1, #MISIONES_20[C][R] do QUEST(MISIONES_20[C][R][i]) end
	elseif bruj and L==20 then for i=1, #MISIONES_20[C][R] do QUEST(MISIONES_20[C][R][i]) end
	elseif guer and L==30 then for i=1, #MISIONES_30[C][R] do QUEST(MISIONES_30[C][R][i]) end
	elseif cham and L==30 then for i=1, #MISIONES_30[C][R] do QUEST(MISIONES_30[C][R][i]) end
	elseif bruj and L==30 then for i=1, #MISIONES_30[C][R] do QUEST(MISIONES_30[C][R][i]) end
	elseif mago and L==40 then for i=1, #PORT_MAGO_40[R]  do PORTALES(PORT_MAGO_40[R][i]) end
	end
----Comentarios y varios items residuales de quest-----------------------------------------------------------------------------------------
		if guer and L==10 then P:SendAreaTriggerMessage(Complet..Def)		 
	elseif guer and L==30 then P:SendAreaTriggerMessage(Complet..Bersk)
	elseif caza and L==10 then P:SendAreaTriggerMessage(Complet..caz1) D(24136) D(24138)
	elseif pala and L==12 then P:SendAreaTriggerMessage(Complet..Reden) D(6866) D(24157) D(24184)
	elseif cham and L== 4 then P:SendAreaTriggerMessage(Complet..tier) D(6635)
	elseif cham and L==10 then P:SendAreaTriggerMessage(Complet..fueg) D(6636) D(24336)
	elseif cham and L==20 then P:SendAreaTriggerMessage(Complet..agua) D(6637) D(7767) D(7768) D(7766) D(23749) D(23871)
	elseif cham and L==30 then if H then QUEST(14100) else QUEST(14111) P:SendAreaTriggerMessage(aire) end
	elseif bruj and L==10 then P:SendAreaTriggerMessage(Complet..abis) 
	elseif bruj and L==20 then P:SendAreaTriggerMessage(Complet..sucu) D(22243) D(6286)
	elseif bruj and L==30 then P:SendAreaTriggerMessage(Complet..mana) D(22244)
	elseif drui and L==10 then D(15710) D(15208)
	end
end
--------------------------------------------------------------------------------------------------------------------------------------------
local function LogIn(E, P) -- Mensaje que el jugador ve al logear
P:SendBroadcastMessage('Auto aprendizaje funcionando, entrena solo tus talentos.') local C,L = P:GetClassMask(),P:GetLevel()
local guer,pala,pica,sace,cham,mago,bruj,drui = (C==1),(C==2),(C==8),(C==16),(C==64),(C==128),(C==256),(C==1024)

	if L==1 then if mago then P:LearnSpell(1459) elseif guer then P:LearnSpell(6673) elseif pala then P:LearnSpell(465)  
		 elseif pica then P:LearnSpell(1784) elseif sace then P:LearnSpell(1243) elseif cham then P:LearnSpell(8017) 
		 elseif bruj then P:LearnSpell(688)  elseif drui then P:LearnSpell(1126) 
		 end 
		end
end
RegisterPlayerEvent(13,CambioDeNivel)
RegisterPlayerEvent(3,LogIn)