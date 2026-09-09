Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF653FD2B;
	Wed,  9 Sep 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952540; cv=fail; b=e4gt2T4++a/r5zmlUufOR+EZvik45CttfQ8k+QQeKbPftoz0cgy9w9z2jqgK4m0VkY0ncEBWc8KiQY1Ykqh5bHcwebdVjjdLm28JGLeDf19dsFo4NJRVwYXrkCZx7emviowdeNRzN/207nADQ0jOOwXImPXf96sK+I5QiPntWxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952540; c=relaxed/simple;
	bh=rQCzCFcEw6V/tpKW4TxU9jyzXtQu0/w5xFgRLJLTmBU=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=JPGQslW+Ah+iAfpy9xAmMXRyqc42ytwV9PYgcssAG9o8TK4EgWWzacZIO9Jux8Js1HBH6M6QQNVGMEYHOBs6RjaCvcTCUycPwet1SecqJCBqOdb0eCOfXi6oYVpPeWiqAWcS3aTDJ5l+28ww4ur1RFpNA/IlZUNST5dPpZDLn0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vSL+O7Ue; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vSL+O7Ue"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpKAP16we4vX1DBAJk9ITSSKO32n3TqW/PsMnhvl7ZlAhhrFCEevOLUi2SDG7gtFHJ2oT/B4/2mWtVddu4ykWCjPLVtfc/pZ5HSA856D8PktRe17wCYMSc1uconPDcYkRmIWXqf7fc8HANyq1MIzM32RMQQVwNBxAOJ5ABs6d4m1d9VB6DqE/DhpJKy35eAOSWG2190u4phkRMAxuKY9fjxXHa2WRR+zRMBJ9Dr3cy57+B9viJ+Qzz3yQ5CgwBZ2tHvvs7hPpuAi1HbFJFWTW77gU+my4zpHhYamt44bD+KXW2Ah6dYfIMZFz99Yc4tnPlJ7HtcagOS90cxvUaQF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2EICoI3DXmJSOwimTHPQNnlJ07XiBxKHO/f+qzx0ok=;
 b=DxqjKWyKEydJUTsevZ8WA/Hk72GMY/8L8uDrrC43bpmOYczv5RsVrnUvHEzSEo7v74xX9aqhvlhm2oNYgmAp8dmg72CBpPfCsJ1pVDbraXVopQw7w1jQNMqSeHu21hSyTwDyYJgmDYMVtgqyIxc7bNyj39lnurPZuW8hdit06TO2rFOdBi9vZ5mpbuECZnXGxyhucl3DGJlj0RpKRw10xN7qbqutZ2oeZDPAtGc5AA0c09EdSpqelyJAtcRdOVmR2n/ae/W294xr0kzln8PjABwQg04C+3eJXpYls7pooYgJwLpsZyeeFKyJA1WSAUVMxu/XvN4RdtipeI7UZgaptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2EICoI3DXmJSOwimTHPQNnlJ07XiBxKHO/f+qzx0ok=;
 b=vSL+O7UebrvZ99yBJwtg/xLoBcoCC0PWXU4CLhOEMPeq8eFkWxjKPOL1157qx6CpFZT09TZJu/qkouec0HJ+aQFdhcnZGBUJ1yAOM0Q/AVdPRe+V4OPUSjrdw99vBrtWGZNIu6dR+4AekecqdA0BnlARYEbo4DGu+N5eN0mNXKoYYuGL9GOUZYUcfpE2Pi7/OzDUaM2qzIkOWlByvyFtLKvRHjBuw0LAjkAmjWvXo+w43lIfLRJEJqFtUmV1VcIiF7sXTZcHvb4VYj9ICpl0s8DMgQQHi9EUn5/6YuKs3w/3PkIGq/THfEW98HEIRhYrVgV8CrLBtaHKc27FI4tSbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 11:15:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 11:15:34 +0000
Message-ID: <ea413e5d-9f37-46b8-8d93-863aa065a784@siemens.com>
Date: Wed, 9 Sep 2026 13:15:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] watchdog: i6300esb: do not stop an already running watchdog
Content-Language: en-US
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: ba817e37-4ceb-4908-0d56-08df0e63aae8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EAVVrxoVTS2UsA/tmzF+ZnxmnmmAiwy10cyyMU4v3JQIyFzbcwVM5KmMaj95ghi49gpGcW/OgVddvR7vpcugobfKyr/o7hNQ06icOEcEU/AGTOaqllSqTJcfWzul2bBaZ9pUr3jCQVMzPNvnKiBMWzra6l8KtWWF15GyxS7DpVOcjOnqgPTvTJCZ3nk1pTahh4v6YZmmxOereBZ8bTv1ZG8cYbkTkPD9vHp5neASSq4B/rNw8FVUPLTkvDyPmJOobAgfgCTB+SAa56191t2MOQobx8N1eRj6ZLw3oWtesn9GibaOBMUQbFoRRj/joADcIqmfZE4PV90VH1QJ6RhzB0YRBXr0YhfeSbO9vdnHzpB18HwXTfdaLc95Rw7HKpospseRJEmhlFu1/9x8yhPC8/rB3Kr3iSLmv4t2MrnHbJuEKEhPNcC5sjikY08kM8fFQy5HdaMVIUqKTkjb4tWlook/2Lan8LLiu5mWjgRfMIN4sQVvLX6Y1WGruPbsqVuNhJf6Gcc7poEEERgOQ+AL5gm3UtizcBF+DZPN0k7q37JxWVJAba3c+dTawKnHcw9nnDKkL0eWtyNdARM+mq2cETf10ou7GzwGB4DzNO5emlf0Zcsw3jf/rNX4d4rqNy1FffEej/bRXIJW6UuKcEsPyfX6YdnarYE14E7vHwnbiho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHQzMmlXRmJrQXlCL3FFVFg3TmVVSUh0WXNFZ3dCMTEwT1lxcHBTTEZhTmJW?=
 =?utf-8?B?dklYNk5hbDR4RXJXdFV6NGFnVGdqR0hQNmNwTWNnb3lIc004M3cxeStOcEkz?=
 =?utf-8?B?RHBvU2t2OVU0RkRkaG1SRDRxbHJ3UTdDQVZMTWl0K1NGVFZiZ0x1TEpVc213?=
 =?utf-8?B?RHhtcDBaNTNKV3ptWUxpSWhCeW5SbkppVzUwNzZOT29QSithUlY5dlN2c0Rw?=
 =?utf-8?B?OUtBNDMxZDlqSGdrT3NPbDk1ZW5TQlNkMWZxTDZEVDFXb0xzVlQxZm1GYyti?=
 =?utf-8?B?RzBiL1ZvL1NoOVZQZVBOVGNJc2R5TCtJa2ZpSzg1dzFtdW5FZnRzdW5mYnpn?=
 =?utf-8?B?UGFrZUlZNldpT2NrMEVScmRmN3FvejlYWUZkbmltc0dhT1VWSnU1YlVtdkhX?=
 =?utf-8?B?akV1SysrdG5OcWVkeURqMFdrT0w4UjAzVzEwdWdJTy94ZlRHNTViV0J6K2RQ?=
 =?utf-8?B?ZXV0SXdDQk5sS0RwNFI1K1I0TGJBYW5ocXhHc1hoSzl4dHJiTndHbEN5Y2ZL?=
 =?utf-8?B?MzFBL2xsaGxKM1Fxb2tqU1hvbS9vaGh0cjRUYWZsdlgzUE42dUF3UWU0Zy9E?=
 =?utf-8?B?RjZQL3Fpc2MvVkJFbFVEc0toOS9qZnIydGNraXVTWkRWYkhYaU5jVkFLdUgv?=
 =?utf-8?B?R1dBUm12bnVyeGpaeUNQZ0tORC9YUElvVm16WUtydmtBMjVrenUzem9zSnpv?=
 =?utf-8?B?VzByd2RlZUE2VXFKOE8vRkk1aEo0OGc5YlFQSlJVNFBONDZWUFBFSEpxb0RV?=
 =?utf-8?B?ZFhseWowbWJiV1JpS0F4NWNFMEZhMUZnL3B5K0daektGT1NKejlzMlRyL1Yr?=
 =?utf-8?B?Ykp6SzNJeUZRN1I0U2N3OEpDejNXSWlYL0loUEdEeHhnL1l5T2RZSzRDSXFE?=
 =?utf-8?B?SThCMmlWdTdUdFIwNVNLRFlRUHBZMEpRaE1qU3dIYUVTeWRKNnhzbEswcmxw?=
 =?utf-8?B?ZTBqejRXZjMyT1N6TCtEbkY0L1hSakZZVmlvRzdEWEptMHZ5RTRjRHpJVks3?=
 =?utf-8?B?cjZCUCtzOGRVck5IUDc5TVovR0tTMCtDWS9XQkU1TmtnaXQ3aEpzRE42U01I?=
 =?utf-8?B?MVdlOUQ2clhSL2wyTWxVQVQ1SWJ5VTZtTDNabStkTWtWNkttaHNpaGNuRlNs?=
 =?utf-8?B?SWpuMXNhaGNJWHZ5QlFnN1F5dm55TEVtRktFc3N1N3RkSS96Z3RCWUNFNksw?=
 =?utf-8?B?TFVzalg2YTYwQXJOd2crcklESW42OC9RZWp3Y2wwZ2Q0dmovNzhIVXFoeThs?=
 =?utf-8?B?RWlWZUtUZ1lNQUZKWmZLbDh2cVhTYW05L2JodG1rL05JeHdoQXl5RkJja3A4?=
 =?utf-8?B?UUtZcmtVWjF0Uy9xbmwxZjJwQVZYQ0NDazRNSWxobm9xZG1WZS9iRXMrV2tY?=
 =?utf-8?B?MTlPRUdXZHpKWWhSYXRjU3Fqdmx5N2pIQzArTVRRZWZCbkk0RW8wZ3hXUTV6?=
 =?utf-8?B?d3pVVXkrMllFRUFPaTFuOVJrcjJDTXFtTHY2RnVyZ2F3c3NOQUlpQktJdkFU?=
 =?utf-8?B?NG9FU2R5MnhvaGUrZWwwTk83akxqVURQRHFHRFhBV0l1SVJnZ0lZeHdQb0JT?=
 =?utf-8?B?ZG9VOHl3RjhyRE9ldlVGbTlScVFoUXM3M1RzRzhIS2FRamdZN3lha29hb0pD?=
 =?utf-8?B?ZDR6ZjB5V21xeENiVDhBZzVIc1ZOY2ZBdVlqR2pzcGYybktCamFzNnhHa09x?=
 =?utf-8?B?S1JHdDdHMUtESG41Y0x5SDNNclhTR3M1L0xlWTBPUVdxdnFid2tVQTdqNWR4?=
 =?utf-8?B?cHZsV3picWdxRCsyUlFXN0VoQkxBQ0FIbWtyR0RVWnYwZDFDMDZ2enc1dE03?=
 =?utf-8?B?UzlDNzdkQ0N5c0ZnU0JVZ0x5d0Y4d0xZdGxoa3RTWjEwcHFRK2dTQlpqOVB1?=
 =?utf-8?B?SjZFS0dZdC9ubTFQaEx5eG5BRVpmcTlCb0VLdGVoZWRqTXFmVmpNNmY0a0Rx?=
 =?utf-8?B?Sk5WZFNLVGpPM2dBeHUrK01qbDFkQzR0U2dLc01xZGpCY1hITUlyejZPSmlO?=
 =?utf-8?B?dGZtV2hUakJzUndyT0RVajk5dit0THh1cUd3ZWc2TitseWl4ZTF2amg1N1Jw?=
 =?utf-8?B?L2QweFZ0K0NVZXkxNE04MXhlelpDcVBDcGhNREc0V1ovUVIvWmtjc3N2M0R3?=
 =?utf-8?B?OUt5dnY2cDhRMENJTWgwMkc2VWV3TE9hSm1QSXRqbmtZK1IrbUhNdXMwYVl2?=
 =?utf-8?B?b2hEZXV0bjhhWTRPSk1HUWEwM0ZRWkdoWHkrYU5JVWhBWWpMa3pBN1ViOWlB?=
 =?utf-8?B?NVdFQk9sYTNURVRnZWgycGVGWHRPZVhPUkF0QUNZSUZaN3RBTmxoenhhdnNv?=
 =?utf-8?B?azBOemZaclJPVDlkT1I4VzJwbEhrUHMrM3JMdGd3Z1IxU0ZqK0Z4YkRxemQx?=
 =?utf-8?Q?Dt3e8ZhlLAkqqRR4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba817e37-4ceb-4908-0d56-08df0e63aae8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:15:34.3201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifaZOC/sdweX/Alyo9wPMKlFH1ZIYi3WdWZqgCnHbJc1icMbvwm9zoEDomU7ruCQXGQYmj386u+Pcg2Tw8l2yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7043

From: Jan Kiszka <jan.kiszka@siemens.com>

esb_initdevice() unconditionally disabled the WDT, stopping a
watchdog that firmware had left running instead of taking over its
care. Detect the enable bit in the lock register, set
WDOG_HW_RUNNING like the other watchdog drivers do, and simply
reset the timeout to the configured value.

Assisted-by: opencode:Qwen3.8-27B
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Background to patch this: The i6300esb is the only watchdog model that 
QEMU provides for non-x86 virt machines. It can serve there to test 
complex system integrations. Patches to add a U-Boot driver were sent as 
well:
https://lore.kernel.org/u-boot/cover.1788526864.git.jan.kiszka@siemens.com/

Background for this unusual as assistance: While crafting this with own 
hands or using some cloud-hosted frontier model would have been much 
quicker, I used this practical case to try out what could be done in the 
background on my ordinary notebook already. Reviewing, testing (it 
worked immediately) and a bit shortening was done by me, analysis and 
patch fell out of the opencode after some half-day of thinking.

 drivers/watchdog/i6300esb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index a30835f547b3..13daafe05c43 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -264,13 +264,21 @@ static void esb_initdevice(struct esb_dev *edev)
 	 */
 	pci_write_config_word(edev->pdev, ESB_CONFIG_REG, 0x0003);
 
-	/* Check that the WDT isn't already locked */
+	/* Check the current state of the WDT */
 	pci_read_config_byte(edev->pdev, ESB_LOCK_REG, &val1);
 	if (val1 & ESB_WDT_LOCK)
 		dev_warn(&edev->pdev->dev, "nowayout already set\n");
 
-	/* Set the timer to watchdog mode and disable it for now */
-	pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
+	if (val1 & ESB_WDT_ENABLE) {
+		/*
+		 * The watchdog is already running, e.g. enabled by
+		 * firmware. Do not stop it, just mark it as running.
+		 */
+		set_bit(WDOG_HW_RUNNING, &edev->wdd.status);
+	} else {
+		/* Set the timer to watchdog mode and disable it for now */
+		pci_write_config_byte(edev->pdev, ESB_LOCK_REG, 0x00);
+	}
 
 	/* Check if the watchdog was previously triggered */
 	esb_unlock_registers(edev);
@@ -301,7 +309,10 @@ static int esb_probe(struct pci_dev *pdev,
 	if (!esb_getdevice(edev))
 		return -ENODEV;
 
-	/* Initialize the watchdog and make sure it does not run */
+	/*
+	 * Initialize the watchdog, keeping it running if it was already
+	 * started, e.g. by firmware.
+	 */
 	edev->wdd.info = &esb_info;
 	edev->wdd.ops = &esb_ops;
 	edev->wdd.min_timeout = ESB_HEARTBEAT_MIN;
-- 
2.47.3
