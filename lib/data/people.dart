class Person {
  final String name;
  final String phone;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

final List<Person> people = _people
    .map((e) => Person(
        e['name'] as String, e['phone'] as String, e['picture'] as String))
    .toList(growable: false);

final List<Map<String, Object>> _people = [
  {
    "_id": "6502b263e8cdee60af7019bd",
    "index": 0,
    "guid": "8cd8569e-bef8-4ff7-98ad-9406d54bf892",
    "isActive": true,
    "balance": "\$1,537.82",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "blue",
    "name": "Keith Burgess",
    "gender": "male",
    "company": "COMBOGENE",
    "email": "keithburgess@combogene.com",
    "phone": "+1 (925) 509-2910",
    "address": "571 Henry Street, Dawn, South Dakota, 952",
    "about":
        "Nulla sunt elit culpa sit pariatur tempor sint adipisicing dolor eiusmod minim exercitation minim cillum. Officia aute ea qui excepteur esse esse. Culpa proident excepteur occaecat mollit nostrud cupidatat anim aliquip ea sint aliqua. Duis aliqua labore nulla eiusmod non occaecat aliqua non cillum adipisicing in minim. Magna id minim anim velit veniam amet adipisicing est nisi veniam.\r\n",
    "registered": "2021-05-29T05:32:58 -07:00",
    "latitude": 31.501699,
    "longitude": 53.838406,
    "tags": ["id", "laboris", "nostrud", "dolor", "id", "laboris", "sunt"],
    "friends": [
      {"id": 0, "name": "Dodson Cote"},
      {"id": 1, "name": "Brock Logan"},
      {"id": 2, "name": "Bridget Allen"}
    ],
    "greeting": "Hello, Keith Burgess! You have 8 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6502b2638398e4f1b526ad7d",
    "index": 1,
    "guid": "462e38f4-66b2-4537-91bb-04781c9b31db",
    "isActive": true,
    "balance": "\$3,174.35",
    "picture": "http://placehold.it/32x32",
    "age": 23,
    "eyeColor": "green",
    "name": "Donovan Grimes",
    "gender": "male",
    "company": "QUAILCOM",
    "email": "donovangrimes@quailcom.com",
    "phone": "+1 (934) 454-3225",
    "address": "683 Prospect Avenue, Bethany, Iowa, 9577",
    "about":
        "Ullamco sunt id eiusmod est exercitation id id. Eiusmod tempor fugiat exercitation voluptate ad minim fugiat labore nostrud velit. Consectetur dolore quis cupidatat exercitation. Ipsum excepteur fugiat id esse pariatur voluptate sit. Voluptate laboris fugiat mollit est sunt ut et amet velit sit do.\r\n",
    "registered": "2016-02-12T07:34:47 -07:00",
    "latitude": -55.24509,
    "longitude": 166.031096,
    "tags": [
      "culpa",
      "elit",
      "minim",
      "cillum",
      "consequat",
      "Lorem",
      "consequat"
    ],
    "friends": [
      {"id": 0, "name": "Watson Cooper"},
      {"id": 1, "name": "Jerry Rivera"},
      {"id": 2, "name": "Lorna Long"}
    ],
    "greeting": "Hello, Donovan Grimes! You have 8 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "6502b263c4989ef3707ab5d6",
    "index": 2,
    "guid": "27bb7eaf-9e86-4eb5-be2c-06145b60c3cf",
    "isActive": true,
    "balance": "\$1,854.07",
    "picture": "http://placehold.it/32x32",
    "age": 33,
    "eyeColor": "brown",
    "name": "Hannah Heath",
    "gender": "female",
    "company": "SENSATE",
    "email": "hannahheath@sensate.com",
    "phone": "+1 (952) 524-2584",
    "address": "591 Brightwater Court, Tecolotito, Marshall Islands, 8400",
    "about":
        "Esse ipsum dolore enim fugiat ex nulla esse proident aute. Laborum aliquip est adipisicing consectetur enim consectetur commodo non ad velit dolore culpa commodo fugiat. Voluptate aliqua do do consequat. Laboris mollit adipisicing proident amet.\r\n",
    "registered": "2018-04-19T12:51:51 -07:00",
    "latitude": -73.780266,
    "longitude": 165.806891,
    "tags": ["ut", "Lorem", "sunt", "pariatur", "sunt", "veniam", "nostrud"],
    "friends": [
      {"id": 0, "name": "Patsy Sexton"},
      {"id": 1, "name": "Bethany Morton"},
      {"id": 2, "name": "Kasey Salazar"}
    ],
    "greeting": "Hello, Hannah Heath! You have 2 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "6502b2630eb44a5e7987b1a5",
    "index": 3,
    "guid": "aba62ff6-bf01-4d13-aa3f-449dbf19e3b0",
    "isActive": true,
    "balance": "\$1,631.73",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "brown",
    "name": "Kathrine Howe",
    "gender": "female",
    "company": "PRIMORDIA",
    "email": "kathrinehowe@primordia.com",
    "phone": "+1 (805) 513-2016",
    "address": "440 Monroe Place, Weeksville, Georgia, 8741",
    "about":
        "Fugiat in mollit exercitation laborum ipsum amet excepteur pariatur aute veniam id tempor tempor irure. Cillum eu minim velit do id. Lorem laborum mollit esse esse voluptate irure.\r\n",
    "registered": "2021-01-30T06:39:53 -07:00",
    "latitude": 41.396217,
    "longitude": -155.714591,
    "tags": ["ea", "dolor", "veniam", "deserunt", "labore", "do", "minim"],
    "friends": [
      {"id": 0, "name": "Serrano Stuart"},
      {"id": 1, "name": "Ophelia Knapp"},
      {"id": 2, "name": "Meyer Booker"}
    ],
    "greeting": "Hello, Kathrine Howe! You have 4 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6502b263f59e7a9fecd5bb2f",
    "index": 4,
    "guid": "89d198dc-85ad-4bc4-b80c-ccbdab176807",
    "isActive": false,
    "balance": "\$1,636.91",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "blue",
    "name": "Wong Dominguez",
    "gender": "male",
    "company": "FREAKIN",
    "email": "wongdominguez@freakin.com",
    "phone": "+1 (800) 512-3646",
    "address": "813 Cox Place, Sandston, Missouri, 4821",
    "about":
        "Nulla ullamco consectetur non reprehenderit velit officia est sit eiusmod aliquip. Laboris duis laboris do elit cillum reprehenderit magna duis commodo irure cillum commodo voluptate. Nulla elit quis officia anim laboris culpa dolor sint ipsum cillum tempor ut.\r\n",
    "registered": "2017-07-31T10:11:53 -07:00",
    "latitude": -55.970115,
    "longitude": 122.432659,
    "tags": [
      "id",
      "tempor",
      "officia",
      "veniam",
      "reprehenderit",
      "officia",
      "qui"
    ],
    "friends": [
      {"id": 0, "name": "Stone Morin"},
      {"id": 1, "name": "Jackson Parks"},
      {"id": 2, "name": "Howe Hewitt"}
    ],
    "greeting": "Hello, Wong Dominguez! You have 3 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6502b2631ef1e67bb1e9b2bc",
    "index": 5,
    "guid": "f9cf9f0e-2244-42e6-b03f-d594ef134758",
    "isActive": false,
    "balance": "\$1,803.63",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "brown",
    "name": "Moss Jacobson",
    "gender": "male",
    "company": "COMTRAK",
    "email": "mossjacobson@comtrak.com",
    "phone": "+1 (815) 568-2662",
    "address": "992 Bartlett Place, Gerber, Virginia, 6027",
    "about":
        "Adipisicing esse sunt culpa velit excepteur mollit fugiat reprehenderit Lorem officia. Id elit officia esse tempor. Sit ea enim non ullamco pariatur id magna deserunt nisi est irure dolor qui est. Laborum est irure do cillum. Nulla cillum commodo non Lorem cillum eiusmod sunt velit enim. Cillum qui officia elit id quis adipisicing anim minim id occaecat consectetur.\r\n",
    "registered": "2018-03-23T01:26:14 -07:00",
    "latitude": -74.243646,
    "longitude": 105.422088,
    "tags": ["nulla", "Lorem", "est", "labore", "velit", "elit", "laboris"],
    "friends": [
      {"id": 0, "name": "Leona Conrad"},
      {"id": 1, "name": "Benson Wilcox"},
      {"id": 2, "name": "Nettie Kramer"}
    ],
    "greeting": "Hello, Moss Jacobson! You have 6 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "6502b263499bad795af6e72f",
    "index": 6,
    "guid": "694fe299-ec42-462b-bb8a-d526964db9ca",
    "isActive": true,
    "balance": "\$2,242.11",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "green",
    "name": "Bridgett Hurst",
    "gender": "female",
    "company": "AQUACINE",
    "email": "bridgetthurst@aquacine.com",
    "phone": "+1 (960) 416-2985",
    "address": "655 Lott Street, Laurelton, District Of Columbia, 671",
    "about":
        "Ut irure non velit ipsum et elit voluptate quis pariatur laborum irure amet proident aliquip. Dolor voluptate cillum mollit nulla commodo fugiat. Ipsum incididunt veniam adipisicing in aute velit anim nostrud. Enim exercitation occaecat mollit do fugiat aliquip et labore enim eiusmod proident duis nostrud deserunt. Irure dolor sunt officia culpa occaecat laboris reprehenderit sint. Esse nisi aliqua non voluptate culpa Lorem fugiat officia.\r\n",
    "registered": "2021-05-20T10:23:05 -07:00",
    "latitude": -15.331535,
    "longitude": 131.265743,
    "tags": ["eu", "est", "exercitation", "est", "incididunt", "enim", "sint"],
    "friends": [
      {"id": 0, "name": "Isabel Berry"},
      {"id": 1, "name": "Kerr Sims"},
      {"id": 2, "name": "Dionne Allison"}
    ],
    "greeting": "Hello, Bridgett Hurst! You have 5 unread messages.",
    "favoriteFruit": "banana"
  }
];
