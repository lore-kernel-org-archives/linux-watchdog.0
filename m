Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0E481A86;
	Wed, 22 Jul 2026 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709791; cv=fail; b=pwH5pN5sJQ5eXufxiul1Rn9N4LoDD4DIkkJt0vnL1ktU79SKepO9ycIBGlutMBoUz71beQ1czLWIEJKPfZSoJBKDXYT4JvkyUzadbIqndhYIUTHjlkU9LMg4ZuMH6ewn7iRAw0Bzm3+jq5EBSrIL8dD2KRCVpXMlE5rK7EAgaJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709791; c=relaxed/simple;
	bh=NosyOLreUzlhSfiuHsl/cxbxMLte3gDJXroT/JgjAVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sBeNz5+KPmPQm3nXdDPkQ/KtT3vyaW/ULxQihG/jA6R2KUHo3Flx0iKN01ugK8kCScvpts/ZmxsjMqmw3LeC0BokOop5pRfSnyyetVc9SwJTPEHBijUXovy/S7Zo8+GnYPnC9219L2iRsIgeiYfhw7Q8nvPkkaM9dNeWR/aLXuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D9YdTqPi; arc=fail smtp.client-ip=40.107.75.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D9YdTqPi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9A5imOs2ITNjAQDSIHNMIkdWv6Oa1J1RaCuFuaASwpyzA77nlFDjiynuRXjIleB7E7udNlQzPPNapZ8jKafSyr08FtbiC3dz3b1rfIAojr/4N0q2T9KAbcP5PEiMQowv/NDc7TGnetQ1K4XYeNlKqc8BGr073dq8Bf+HWTidVPaA+IbGrEtMaFfRwZDkhXYH+NjC6CApfUx7OdMcjyl9OKDIJi/2INO8GtxwujiyHrfsgC1+HZKiFSYzKv4jfRIxecU4t4h5UPA/jEn2cmFjEgbVqL5ighl/+DLRJqWl6QwGBFrKHLY5kDTBLizEhqJPO2aQbiBQHgVA7iMRyyZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75U+EZll1Gm+bSDexnWJkLRKTq1NK6ISsOqI25az8Fg=;
 b=G7R9JR9Q6l3c6Lzl28JlKhKoo2xyO+K3+wktVx3QeWaWKRr4KcKiWpZig/vszldLeJsW+OpyBpu6MItfZny0/szA4Rze0+OWXSxGH9eEbGJAOCUnfLQuKl4QLvzWmjWu4cETwlZpcJXlkq1G2Duk2D5WZi8/orq6hNE2wOplByf1aV+154l6qbkHrAAZuhOWWN4X6U9k8Mkb7q1crqg7UZusnTNSBhdcSD6DOzQZhBUgYqYJnnFs5fP7mXBgNpddSpcn4KLKL7/dOzHXh0UYo4Ppf1e5WpAWAHaaVXbv7TNBrY6NwGOVyrIRyU4dFLB8solcNPvTttVqm5EiVlogzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75U+EZll1Gm+bSDexnWJkLRKTq1NK6ISsOqI25az8Fg=;
 b=D9YdTqPiLDehkVm2XzPwfmLiIhZMrit/6S+ArqVM15EwnE1ByzEl85xKhZPUcn+C8HgAwnc2AH1ZMpASzPlB3ydwh2HA5V3KRUZ2vX5GZ8ONLDASN/SEIpA/Z9brQagVD6jSqcAB1ugrFWVaAKYuFJA7/Iw8if9B0UK3nk006cE/i+w521iDHzjO6+2+Kht50HdV1FXnkzthUEYoLznaCeV14yfIFAhkECbCpWPt9Op3uH7QlBND+pk78ksu4LFkWUVdeSt3V3aw7J6yh6xvHFm8qHkhJj8eyZcpbtDELGk1XJWLtgyuy8AgXULdyhmyM+37FkSlUCus0pd/8kSHcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB6037.apcprd06.prod.outlook.com (2603:1096:101:ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:42:50 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:50 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 8/9] watchdog: sama5d4: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 16:42:16 +0800
Message-Id: <20260722084218.79073-9-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722084218.79073-1-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEZPR06MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: e64a4e1c-ce0c-4992-cb9c-08dee7cd3689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	o69Cc2n+G5ttf1ZeXs1jvXQxJoclKxFT/EBf6Ix983wuBY5PyoeUgMxnvwkLRAuWn1ljd2Ay3wytq7bD4oZeYZ2rMgJOQ29PDlg+8T9t9522QIAsrhOJhEY9WMdHWciy4uw1ZtpGLrda+nRtcoeRta5+90t3mmsZ6+NyWqxfbDAhegtps0yJPG331nOH2+6yq7LsVOPFpc5T+5vHTGpvhgGZM30iFgI/eEhOv7xV0vL2K6GX7KRR9/uRSul24XizBIqZnUabEKFP/tp1A1HTv86UP2jN/4zLQFSSQdhLinRhqkEICiGSwakd29WAGaxch2bUoNgXkW6r2RB/iMrI5fm4t1TlHIzlTMXDX3C0b4jaa6KP5Nz2Z/xO0F75aa07lHljyenbJDr9cZDQ2/taGQjz5K1rbhmYCp4iejz9rgwNXcdUjEUWJnkMmBVvzWYHWtVwJktCG8vundbv+Y9z30sQhctSOOycvMyi4b7u8+11Zy0GZSSuia69A0C+WsB81P6c3uJg3jAcNU9i7jcoQtJLsWqRY3r7dAP9AVuDtvOM/iPJYh/dccgk1Gy1NDWVI/9RZzev8LboqPEHMygfNb047Yd/sxOPLfjSkKy6zLg1n0WBR3JznmwXkhsp68Nd6p2H82t+eM3Z11ctqnIclSe7SKCDQbYN/kvigVIQQvSaTnXo/1z1leZbBWjcitA8n0m6PLd70ut4XDsOCkBkP5n/7FkxaaajRJfQw/TB92o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?udrUty9efItq3U5xy69B+/CdS/ZugK8Jd/pJobkUmTce+BT8tVCebVRij+wb?=
 =?us-ascii?Q?RcRZ7RiHY5WnrC333gQIiEJc7HtE4WqiXWRvKvyNZ3ajMe/M8vbDGw3Ve5mD?=
 =?us-ascii?Q?Hgono7Gle48YzezkooJ72w6ZfOvHKOeUUttcWDso6P7spwXjAhIzZeqTFKuL?=
 =?us-ascii?Q?0cn6Jh05ZEXFHGk9+xMWmFf5IQfKUsEZtOhG9r8KDB9J3kwfhmbB1buZTjla?=
 =?us-ascii?Q?NhkIjjglvsMnIRoziOZBMxwy5/LOC5n+6+6ai1x1C8s3SzBt5XKSqJ3LmzC7?=
 =?us-ascii?Q?5eBenVP3bchU4Hp9d4eIPJoU++XwwEJlAWp8l69+CGVutl0yA+SCPWfYXVc9?=
 =?us-ascii?Q?WozIVTlj88SZqW9wWXEy3sfdfh/U9RuuJXgFXonWCRTSB/UGpIE1ZP5QQyb0?=
 =?us-ascii?Q?XlO/iY55oxuZZL83bW3JM0qFCr1Jw747dhcpqpC4NYz/S1clxRVNzR2ww0P3?=
 =?us-ascii?Q?Z/6cYQ8s+t4y1hISyGLwQ6UCrYXDrPuwTlqUd82pNg6FEtqGQi45P0npFSRL?=
 =?us-ascii?Q?1V/s2FiH7w+HZC/9D8829p5N3OVk72RKcuxjQmqJC69vKm8g6OZIIfgKJ98E?=
 =?us-ascii?Q?4M4MyvP68J4t4gBaAst0rpgQEBeVMq2EiqkPT7haLarS5ZNA2upOH8V3VHDR?=
 =?us-ascii?Q?Xe9LKLRE2B/Yizx2iVqnG0QTW2ZmKXnBpESe2TA0nKbq1USFUYqawqBbaSht?=
 =?us-ascii?Q?hshn0ZnZZC4tg8sCeEe5xMKbTMyhLfWvRUaN5vZtEAR7e3hWAISNv0fSuhCy?=
 =?us-ascii?Q?ldfWqG9ROHf9AulDBkEVNviOkbC/NRBuGuqDMUf0cYH5qNqCT/j2UVb4zrtb?=
 =?us-ascii?Q?q3IYCRAS751DLfcDcutVGHYGW6YDHaE/8EvLG+uu2s4T83u2/4jS8qRScS+O?=
 =?us-ascii?Q?74ZHGnXApjGTZYUBkbca2s8IHr+c5puqltyhEoW3tcNQxrkeed92fsCy3JjH?=
 =?us-ascii?Q?bJrEq6nui/C1pYMwDefexCcqjcYYgOlKVpCbvpMNCakEQiJoZxLCBILlLfDI?=
 =?us-ascii?Q?9cGJPvh3VJ2VoAj5kPuSV9YrMrAa4jJSAzF1gNuCebWOB8zM9wesZl2Fw0/f?=
 =?us-ascii?Q?0hzPx/lQ5Y2on2SUMYCPeoMH+DLB2uJ31nXeBsdPw2OJvC+UEauO/eSc1ITM?=
 =?us-ascii?Q?r4IioHyv8hQRKS2PNIta3I4oKR35nv/tUUdhPa9/ZWWuIOJXRwqwlDBpENJi?=
 =?us-ascii?Q?2DmD4T57Ppk9Bz9Z+ppOzTffh1Kan0MTaUx15DQo3qm2AMg6LFcx3Mu0nCW2?=
 =?us-ascii?Q?CaDJqcPz9DdKtMeH06AknxKZ/zhI0thiQvSZP2iJN3c2lh7tqQKq18EmMezw?=
 =?us-ascii?Q?of4MS9vJ2AmiaV2QOhkVXvfQlkcd7L42xs0OMGAv5SpLFhRtGK4ANFkPSnH0?=
 =?us-ascii?Q?1DaJGD7LfDa/usbXHsGR5Aftd/ZV7AdtfH3OgtGRVSbmlotOYCRZEMsfkpUS?=
 =?us-ascii?Q?zPUVEI8HOIQelIZxhlsBUlKpKFVZkWnNaLWBqzH9m6Y8YG+O0HK2T3pJLJmk?=
 =?us-ascii?Q?dGS8onBoGMCbej/4uBSmf/TWsCIHG/+bGc8EaC8aBaN1p3Qh3JfbipW3e1QH?=
 =?us-ascii?Q?CDaleAQJOge4kl964pIq7hrKiMnulpEwwI+sX9m/Ez9P9tnp9/RiL19MEjLo?=
 =?us-ascii?Q?o7Gfo1bxhkISJxZpvQSxTayxqzdkQ4IyPef7cREcKKAr+jqYOHvsz+mWzsrB?=
 =?us-ascii?Q?9mMium+gKupXghnij/vYAKN06/hGs1NXo/ox86YooLxCWXOwASfxHvDjKLBq?=
 =?us-ascii?Q?sOfiSdjUXw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64a4e1c-ce0c-4992-cb9c-08dee7cd3689
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:50.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fwki1v0yCNEYse2p6VaStt0+SxXhiHI5vHNgyMPenyVi4SbzsZZVRXDJTY9Gris/jA3iSpm3iJnQ0I7394D6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6037

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/sama5d4_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 704b786cc2ec..ecdd9aeab79c 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -291,10 +291,8 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
 				       IRQF_SHARED | IRQF_IRQPOLL |
 				       IRQF_NO_SUSPEND, pdev->name, pdev);
-		if (ret) {
-			dev_err(dev, "cannot register interrupt handler\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	watchdog_init_timeout(wdd, wdt_timeout, dev);
-- 
2.34.1

