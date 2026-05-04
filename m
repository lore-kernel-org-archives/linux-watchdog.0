Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022143.outbound.protection.outlook.com [40.107.149.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39B3D47D0
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902756; cv=fail; b=KVmral4R55H3tWwIdP4ByDNzAs41dbkDcZBNxPpfrh3NYZL/x3gQgo6Ipqw/mp3lwnT1JDNvzR4HhPMYfJNXV1d9Tq0bwoaFXgBq+bCsNe0EAV5+l3dr7uH6IwIxMfAghD7rnYfBgpVunRrdNP2ozfZ8sd7Unli7W9xzXImKyVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902756; c=relaxed/simple;
	bh=VbppL8YgDnA8b8qBcEijT8gb7PkdlCfiOIk7jwV+opE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RllW647+P3keMcTX7NV+u6crQc7osB1XYpWfhdR790a6EDk783TQG/uD/Nwzcjbd76ZX9SicBAqb9FB7/gOrTxYbIiJy3PsKnqNaW+rjrkvUFgmeCNBxDLcsWj6HSUrn3wS7SpyLDZz0qZcsxWLSo+aST5XGvgj07qsz0eqaHzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=IFR78aMa; arc=fail smtp.client-ip=40.107.149.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="IFR78aMa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYvnr/G/YIMMFhe7dAYVg1N9hCXiew3OTg/gy47fJEJChzBcbQexbklUYR4flBJh4q/a/duO6cUeISGmXKKEkXjpykaFwCuCvcXyaM0J+Oh6U7woSjD4eODJr5EfgVhQTAH6Q9UONMvE8XJ87DaVfsymryfgbeoF4cfS7jtT/cXaZDyL1P5CDau+KRhmI4NO2Gkv4puNa06kZHGcfbCHKmxxzlzYRilQCip+vPFuIXUAieSElnxpn3pVkEj588vZXZMnNBs4soiqKHzS7HPdvpWQY+OXIHyT1ZmjFEI6gPZcRtD3SIwRQHTLFNoT/hRjoRaXJJBK+vWPbGTiOEyIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbppL8YgDnA8b8qBcEijT8gb7PkdlCfiOIk7jwV+opE=;
 b=i6itDKkatlJfypeeQktBRmatHfM+nIxliQHBGtkuw0tTVo7oZIHtCeh7qmQDdWqyBwwGGont0KucAhALADjpYWvwXBB3WBYMK44Bo3HPyh0S3jLrd6DYBsu7FSFjDB8cu93HX0AJzT9cxacP5uLZcqTQTKjjF8mmQh/IOYCrdfpaEEhjnWNv8AGQIcb8XjtKngk+Rtnvx6xB+d6j6Kv/yu6Wn46GcnFViSLxl3LrhPJXS5J+ZTVJK9X/6G5cAH+Wiz8FlAEl8m+Hu5JG9po1jFrJiQwNwkQibYSG6kpqn6Id0YYIs6FL6PebItp7kaNU3XH6ITkkj7J+VmrjX2CRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fritz.com; dmarc=pass action=none header.from=fritz.com;
 dkim=pass header.d=fritz.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fritz.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbppL8YgDnA8b8qBcEijT8gb7PkdlCfiOIk7jwV+opE=;
 b=IFR78aMaA4nerv8qAGpmcAU/7ADptvYN9OXKbIeaEl1rH31PaKLZxn7uM1MsxxQXxddkN/AtVmmwXRx2OLNlS40+NZW6275j2hNjvKdGZLRnt/6OG9J357lNuQpYun0s8koWlPa2SkzS0jX+9FnpXAa2JEkgdQYNwyunGL0FMJivmb+3i+Y65ayrDvXDtkJSU5E6Y6PYSA8bHkAi+hEjbsZWFPHGVvHsPDmJJoPue35ZPDnX8/HWiwLDG3C5Ck4OsswsuMWuKHT9R8P2EeqIv3mbRaatXfN9sC+snRNsCTQNjEabJpkh+qw1Vakc6r92FRpiTmhGblvFYgIjl2BFIQ==
Received: from FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:33::6) by
 BE1PPF03686682D.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::608) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 13:52:25 +0000
Received: from FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5570:dc75:68db:7a5]) by FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM
 ([fe80::5570:dc75:68db:7a5%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:52:25 +0000
From: Philipp Hahn <p.hahn@fritz.com>
To: Guenter Roeck <linux@roeck-us.net>, "sashiko@lists.linux.dev"
	<sashiko@lists.linux.dev>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: AW: [PATCH 1/6] watchdog: Fix wrong SPDX license identifier
Thread-Topic: [PATCH 1/6] watchdog: Fix wrong SPDX license identifier
Thread-Index: AQHc27eggLRiTARLUUmiKPf1mpu/Z7X94NYAgAAA9zs=
Date: Mon, 4 May 2026 13:52:25 +0000
Message-ID:
 <FR3P281MB22523AF9022B4059696D33BF97312@FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM>
References:
 <5557c8ab4a62750c95631f6f78be7d2b11e091fc.1777892508.git.phahn-oss@avm.de>
 <20260504111735.3D387C2BCB8@smtp.kernel.org>
 <232833f9-5542-4f4c-9bdd-92f72b0597d3@roeck-us.net>
In-Reply-To: <232833f9-5542-4f4c-9bdd-92f72b0597d3@roeck-us.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fritz.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2252:EE_|BE1PPF03686682D:EE_
x-ms-office365-filtering-correlation-id: 7972e743-ef4d-413b-fae3-08dea9e45f75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Yq06tWygxUjS+V0kI8ZGgyVfl9c0Z53tBNisvPDbaCidXNH8A/eDOUlihwP9DlM3Ku0a/wLp55cDZf+OgwrmFCUe22wYZFsDNMxO0jdbMFauXQfwWmSGVGBRuWlPNlsj/2y8pgteLUd/6Ng5B1FgQ9ivVjxv7LEn17rN4hCfZZJZHYPAa+L2VbUFJJH+/TzznyMWyYD3q8aU+4wWDMccvi3/Y+DqtA790yHr5QhWMAVd/AM5N87JMJ62GP9gpMm04BVu3pSpz//mLv54w1A8ky8xaY+rXGeD3RD4nRbNeBTt3JrHnIn2y07prnMI1ei9FvskzHzK0EN6KjoleQPxLAsDzBhKQGoCFHDXlHAhgeXQGdhO9PCLQlsSC8osTrHC5hiRRVgScMhxwFErFViNcUu+lZzg/n/zKgmtKhwyb23fqM7/t1m+eQNfJSqO/6fwDfdHiJbk3x6d7Q+a7bXxyH90y64HlcHNBOyF18fCoYrK2aLRRJaWWSDIzHuZyuOWD3P6VuHfLTdDwlhKxhAnsdR/hRymeqDoRzsfvPsZED1dAh8+e9+RytDBP19hmstoSCCXEdnNP8yE0pw76FlO289cOVXcuu1Rwc20jvw9dsB1dHnu6YuSUpuZ7GfVTs3XmTrj8NVsiE8Q+Wim9AimJSb8fXQF5GnFGknJfeAc4bRNxNmkW8QuxBGrdsjR772YMZfW9/3tUuE4F46wO7rgcP51Mfhx2JqHNp6PCxQfiiwSXPd8HMzuNH2uywfOCEBq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?xG03FH+jxF2wLrk9wdGLTJKwnOyJEIGB5ie3fupfDrcuQyd5VELYoYd2?=
 =?Windows-1252?Q?XoyyAM96chx+C5kTEizvRdQFoldIS0ArZatspvmpxA+N3gYiTtHjjWnO?=
 =?Windows-1252?Q?PjHU0NnWDMg3cQ7Pp2J09/kp0J4HQyjk6+Rg93cKd7bPrDOyYykQ4KeO?=
 =?Windows-1252?Q?8qcoids2s/TZJAdKRNX2q2FL9OfdhAL0+LwsRDsH5VhNf8cLfp3BErIG?=
 =?Windows-1252?Q?8gF8SQKR0JxQGd/NJdU7wUTeJjDL5mP/jg1AnT5h8j9qemyzMfkLLxjl?=
 =?Windows-1252?Q?nle3EvZmbg/QWqo+PBxMgq7DlKdibNgByN6Og227Z6v47kaOKwzABu2u?=
 =?Windows-1252?Q?I0ySa8CujQCfaK8VmE0hj4n9zNJIVKM9pFGWRonO6wiQEo8zD/eMNlRk?=
 =?Windows-1252?Q?Q9IA12LSXkHpCJm5N/KWTxC42Y1CNNsaO+2yHB1w7pFrJxJQlhxrvRtT?=
 =?Windows-1252?Q?B0iy/IvKKFOxRCVSdcL6ZuP2JQKRQfFgA+qUy19fj6stfxgdUBMl4yxR?=
 =?Windows-1252?Q?fSQN2JB/BerUwE+iMVLXbjdQ6d7PKNwXvBeh3KQg+Y+FtWVMvcXY22P+?=
 =?Windows-1252?Q?2rEySr8Ke75ihjKsO4pRdXgaK7NMNKSy1EwLBxVp5TSuY1O5l1s1SuJI?=
 =?Windows-1252?Q?ZqVi9NYgjFCj7PkdM+aXkF9UGUIIV+62PMCjszcPOxqwG4+KIcPQgUMd?=
 =?Windows-1252?Q?H2HBv4hdSwE+C9iXLw//9LErCsl95X1R4EtodCkNYspda1P7KLqCRYiA?=
 =?Windows-1252?Q?3GlZh0/ScPw6Gxyn8IwvIsOv8qXo9bTpS33/zKBnzgqQOaoAM6LygTW1?=
 =?Windows-1252?Q?mgnunRNlOusHMQJ6eoAf9rPZv+WXWU/hnk/e7UKiUQKAPx3IpYvqZ7xN?=
 =?Windows-1252?Q?ZaxmLBJR6moOUdyAIvCKg7QCJxrzsaNJs8g/fhFfcpdUf16Wa6M3aXhr?=
 =?Windows-1252?Q?5yE05Ivume64vwzXeLB33IBpQpT/F9HFbdadE6VbgMrvch1zFVM8LbWE?=
 =?Windows-1252?Q?c3oJcUCu670o4o/lNc+KpV4CEA8778/5P5INnDTcCz5AjJNGoXh2pYDO?=
 =?Windows-1252?Q?+uIM5hc1NSH3p2T8eXpdXLtvNFDTUwyzpfUR7VOoY8U92NzCtUdPJ/vI?=
 =?Windows-1252?Q?gguSCAcVa+HptcwSmUEi+wEcLZwQfxu0rfPhGCfREtcAUsBwuEw3Snlo?=
 =?Windows-1252?Q?EJpVkqA+6qnwc71X4mzHf7S9MclobG9KDnr/bTlBgm7CdeG9d0hPed1r?=
 =?Windows-1252?Q?CwuZi5v9UAQxMqbwb7/byOBuVEHXr7/BiJ7pPUi2+TPcSTu6gCBhCPTn?=
 =?Windows-1252?Q?tX3TcEsKNNmD6hnB/g46Sn0kDcQp9lIKseB6YROWBG5G3F5vwZNEiWLE?=
 =?Windows-1252?Q?58te1sv4fXwyKWbRgnrLZA6KvyuW9VEUczExSef5SBlAEraq5M45kaCj?=
 =?Windows-1252?Q?E5Jj3WyKzLtsKtBe2RkOQ8e0HIc6/l2G3UowYakeuJmPS153TsixPd1h?=
 =?Windows-1252?Q?+QeXNc+hi2WJfdrqQyBvOM+OgV7P9DXNRpIMdsUB2CBZV9ZUPetkb+RS?=
 =?Windows-1252?Q?176W7EBZ6eZRTAG7fM+j50MkDREuNZGR5dAc8zExSnpapSyneJIltM+i?=
 =?Windows-1252?Q?yBDQXt73NdL4sIzG2iwVNx09tP/nZJFbni1uT0b74Zx2bIvGGQdddZG3?=
 =?Windows-1252?Q?pt9DNURR7HwRdbjNSUDK66xygM7qjGFa3IKNNYozFFlLZ70tZrOrGCRX?=
 =?Windows-1252?Q?lCmcCsj4I05TbtEZB2zQp24A5gMUdpbF2ymYmSZPotWS9o+IOxEvVDLL?=
 =?Windows-1252?Q?pym4x8yrdhOoAlstmIBIboAIiDHjJ7vPmd2ePOtEJIST70QZylz+2vWD?=
 =?Windows-1252?Q?dYG9+wKWOCpohD6559fOmZlH3RCaw0mIVqcn8xiuciNkV7ROJ4OknroM?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fritz.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7972e743-ef4d-413b-fae3-08dea9e45f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 13:52:25.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f3ad06-368c-4a5a-81ed-352bb4596224
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QjdGoVEj1V8SgTx9Pdvw0QU4qLGtucS6bQ7+yAD+VNAQAWrQzqVVKjWLr4yq3HqSpelOFvoEUlg2aJ1UtHleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF03686682D

Hello Guenher,=0A=
=0A=
> linux-next$ scripts/checkpatch.pl --strict -f Documentation/watchdog/inde=
x.rst=0A=
> total: 0 errors, 0 warnings, 0 checks, 18 lines checked=0A=
> =0A=
> Documentation/watchdog/index.rst has no obvious style problems and is rea=
dy for submission.=0A=
=0A=
Sorry for the wrong file, but it was =85/wdt.rst which `checkpatch` complai=
ned about.=0A=
=0A=
> Please refrain from unnecessary churn, and from making false statements=
=0A=
> ("to silence checkpatch").=0A=
=0A=
Sorry for that, v2 is on its way.=0A=
=0A=
Thank you for your mail and sorry for the extra work.=0A=
=0A=
Philipp=
