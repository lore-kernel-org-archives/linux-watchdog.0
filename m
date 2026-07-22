Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E09480DF8;
	Wed, 22 Jul 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709785; cv=fail; b=ZsvQwbhY4jfKthKukjYRcDO8OY5FC5mZQfWK4KSNP5+WZZnkcKL/xBg884JtlkuCfPVue6m1+gkrSIFuYCU1PSN9mHER6YHfge4m8qW69vDIM0A2AbmIBN8+6Hp9BBMbMJ4gHfsOkNmdgqD5AWPN+yRow54lN0seHMrV7slUgVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709785; c=relaxed/simple;
	bh=rfKGRBwleJZTA5fIH2UIF2Y0YSkZQGmRXcpOWRDh2Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjD62x0okCTYUz0J6HEXF77gk/TQvjh1J6GMDHw3oDBLI9OKUxpVDvi+k37Vvc6ZljUdmvC4OoiuMGlhv5DSC95/EH1ne8cf2TyBVG1sqnECDnjR7oUu68sLwEHjNwbXHDs6Tvso1wLaEeP7m8JeVz9YIs1YvhLSfa0nMz1V8TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D/4Xcalc; arc=fail smtp.client-ip=40.107.75.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D/4Xcalc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkYC7Po0y/lpMtet8ETWOmhU/4w1Qskl2N6whUPjp1cF/W4bUhpKCbow9iUcq4XUBGeGCH5Y17skyV0rKuCRr2/HcNhO0njyfc/AHA1mjPHmo6MEjJ0TVrwATEA/aoJD+caZGMGT7L+rSTgyGWMIWKE+iY3Pp04uBiRRjdAtj3IAq5/xC3MOE4U9sKE1g+6wsmLkSFd3fmznFTQRPuFzKgFQvH7trSZNvc79GdDyzV5BkbmXydvyELqKeA/0kzjd413GeXQoIGAoGwO5ZHujZpsFDYUyrpzw9b8h9+GN6fmyNPza0m9lvTZl0sVJpM/SNrBaReoOS8Im48JnDfubjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lrfUmWGwKO85Y9VLwTVn6uIZkTzbhmzzS/da+nUt3U=;
 b=YHjnpSYSqybcdKKPBvFkij4Cga1tuMflVhCg52FtYQpe5ulTUT6SVFK4ZDwF1JzXZzi3AcPyAGFzM+ish9ZwVhmS+ktIGtjmnuLcy/gkVerYaZtZy9sE1/Hg3ryVS8GeXVcYG7qegXiWpF2F1HagoZ2ADNbqLyOV0rCbb7NPw/hoBAK+vniVFTW0BBPCth6bcd49RCQOXH7xciyjJwp2hkBJGcd+PIzK6IPPC31Oti70DAcZuroAeuUHIqh2VA4s67tRd3aA9TyI29fZQAJV3AM0HmRLlnRbRYtEfNFB36NHTl3Zdrqh+Htue8dMJ0+BG3NjkkJXsYyQWsCa9r+jFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lrfUmWGwKO85Y9VLwTVn6uIZkTzbhmzzS/da+nUt3U=;
 b=D/4XcalcgpYRRCtjbmIFDGgyz8cc6cAcIPotTqGsWjOIxU6KssRe8tjyT9lpA8/mwbNHtJGj0q0GNIUQFPQjNwXqnouSUcVmIeG8wwqo3ykIxaZ0eRXay2bHhp9qOWdxVBrKRf4kDCLkO3J+PaCu2bH8FwcClqBFsmagoxo25nvx/nyqWbzZ7SHC0Mn45DJQtd/6G6hrfdOpSDYQnk3YSjida0ARHbcu4tOdh/FKEqQxn6AhBbu6hAZEPt+zEzbAzI5jyn/BHcJC2ZSjDCFk3R8Wkb4fNUkRB1xazLdNmcAA1NcnEpN++6YW7QSw6O4ow1OtcXV4kDVsfGCZ9oZDPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEZPR06MB6037.apcprd06.prod.outlook.com (2603:1096:101:ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:42:46 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:42:46 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 6/9] watchdog: orion: Remove redundant dev_err()
Date: Wed, 22 Jul 2026 16:42:14 +0800
Message-Id: <20260722084218.79073-7-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e54b361-203f-4f3c-ff8c-08dee7cd3427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cEq/MFpVNUR9+ei/Z/dYFCeIx/zErN/0U9lVmpx9aLK52HgtZvO/jWlkwz9HhJJ41DJOl3Em/9G4QyDv2OC6azLm+VEmqbMZXm3QmZXa2E5GSr4VUyqWZcrFDg387TUJr7f0JWLhIibiCCneTP8uJIfhxhDCzy8fd+7KTX+WQTvaI5VK3KIV0ibcvyvIUJEKaDe/tVnO5T98Yu/RdZ4Ku/joTqH6RY17hl1ijfNYQ3glzznQaurFRsqtou5goSrtulmh9BL8nHyy31PAhBc0myxHZWNsgfis38zTnUL5Jk3Ck8V45o3sjMgumIPrkjRh9weVPA8zQWB/f0A+GFA5Uwttb/wjxnrxkdtWzVCkxYcEXt5suhpqdqQCEWWk0esOKnWi1/zGLxMXB/bvlfv+CjLG0IUEPG8fxWdps28keZvj0tD867VRgKcD05fOUHAgwPQBJpNoYrfmyH5GTT+QD4+HjfzkY/2cT6OLmqu0CbzWGQfZUvULS9NjvBB6wI68s68TnLEAdo6waQJs/f+gDugv0b4lsIwTOyGEiCcxcFAh+dPyE3iJ3HgAqSd+G3JfiMaQlCu8vYidMwmZCKRCSBN3mPx6bi/roSWgLXmf/rOVr/3YxH0H/twoJfiTfqLmZ8xxh55X35RwBMXfi+cvEo6SvbbhuAfdUQ4V6MmOEin2ynz66L9qTN2tIz+HvZvQZ5D/iQGAS2UfchhkP2z1A722g5x/pGlEQohDH+ztOzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFmPzIoUkB0MTa6tbdnNvJHOpx0RNw0NcY5oZqElBkgF760RX0Y9PWklO5Ly?=
 =?us-ascii?Q?Yjp26QI2XDwh3GvgL10CLT2Pb0pJ9E9uL1wgrGzD4VWpB0f9wZ/ydNNfSmnB?=
 =?us-ascii?Q?QiyqJjjoEVe6KBpt9z69egxTA6v0z4QLKl5rY1kTkjK9GdhFk9j85cSw/VE0?=
 =?us-ascii?Q?U9jTQGcs2q6NgSvFMx0R2QiBAdSgFVAERgpNU3n4opTqZVfrloU4rS357gF0?=
 =?us-ascii?Q?X0Hk/idyljLq1vhBjA7HUymTn5wRDIkfAtEfiqf0e3OtmGNWHwvc793AFElg?=
 =?us-ascii?Q?E8/hMbO78DdH+X61moqyv6rDHgAY+1WCPFCjPLzycYTxrfiYTR/jf1Pw86hM?=
 =?us-ascii?Q?jiQmjcEnZV2thdeAtPsM/Ft8O1lmet4P3PqYY5nmUFPjSfGoQfeOLj+nPzN/?=
 =?us-ascii?Q?YKR151ANERhJtXs23RMwhtkanz7Z0wmDpGGvvTbwxhvJeh51eIvFfmNeaYgg?=
 =?us-ascii?Q?NddwzRg+2TzSrnE/hNmZ4PUz8INoyFV58FBUSy38jRS4G+KQDIG8kAdnuZHx?=
 =?us-ascii?Q?g6bb3/sojFOFnpkBK7Sza6y4YmyC9UkpMfRL7P3rVt07hl9C7XEJjaeupqFm?=
 =?us-ascii?Q?6H5N3DvjK0WjxYAMoilI+tkukq6C21QGbDZN+QNP7kkNV0vfW/eOpKUQoUv3?=
 =?us-ascii?Q?2yNTjDVLT4PxBAK5JkfnHpSKx3ZrI3v2nEE4XO8idhNjPwREHmu3lIAn/ozb?=
 =?us-ascii?Q?co93z2DBhmIpUE33lmCRr+eDOTIganm1Q+N9QLdD4hOGTm17aXO/VASaeKaL?=
 =?us-ascii?Q?c2hGSebqaXfPxtERChV6RDLDvP8kSnp+2nD8sOpXbiaYqFmPMh8ZtlgOuRPC?=
 =?us-ascii?Q?KbVwU9pG/swjPofTKSnk3uYk/1Rk2GdyRckaCp6ivs3LHzaecTnD+MGec6gF?=
 =?us-ascii?Q?HL78cIuuY7kTX6K/FR4m5/X1irEBQRQ405tOF2Ak3/PwfJa8KjPYpFRT+IXj?=
 =?us-ascii?Q?Vnlh/M76CQzQzhoQSTrYlu0rwNxmSKXmPIqUwQE+eQawhhi79iPbKw0PoD8M?=
 =?us-ascii?Q?+dAmgQ+joOjEHs7DHUO/sBhF7sA+u3yiQcHKfliTAJ/j5WsjE/69VMehCC3c?=
 =?us-ascii?Q?/1Wfu6xbIkO1EFNSc2HHiE/e05ACPZntx8Qhc4CSuPjctS14fGVy1+nFU6nH?=
 =?us-ascii?Q?m8otbBUrDwm3sBU6CeRJRmEsBuZaHZYlWqDL3/OagEvb1S/0o7lFoMiJ5497?=
 =?us-ascii?Q?OWWxoBvsLWS2EUq0CN9ZXBbKEvAvSavedGzjXkdvBvz+ez+SvaDCQUVguJUM?=
 =?us-ascii?Q?R9caZAO9aL/KNkwiMZHSUu4tU54MHKfN6Oj8mu8Wy/lvuglLrco5SWm+QZRc?=
 =?us-ascii?Q?+V0Jyd2Zv6vjV5mGwGxj5+WJRZlsmDu07STMQ6QCqdCw0QjAMDdpY4Qg3IHj?=
 =?us-ascii?Q?xn/U7JrK4MsX+PPtyeWr3AkZbUHo0Idj05fL7jZxJwBKUkPHpMDf2CYQWSDN?=
 =?us-ascii?Q?NS1Wo6Avd3nzC1pz2ziXvMAZdNV4agCMTr58JjpX7AlgIJ+oSvWMuMENXxvT?=
 =?us-ascii?Q?KJu3FByr1Nofo+0wHXdjOGEOOdDlFskf/Uzj0N7CrFRUZRdXH8TJGuG9YO60?=
 =?us-ascii?Q?yoJE92F9pMPwNgtGHxfpi5RKiSLBHEqnKzt3HkYPhZdSxYH01Q1zpAPW274A?=
 =?us-ascii?Q?MKHRcnZX+nFPHPTekBr8bpTyU899jYli2ZG0yCqPgrRhZsc5hKb2YtXCwswP?=
 =?us-ascii?Q?rDRuJ98ghFpf5sZfcbrlfe6QPzUp31NBjgHD1UPMVzMSyl5vgH6mwJqQADQg?=
 =?us-ascii?Q?pflbJHBHmg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e54b361-203f-4f3c-ff8c-08dee7cd3427
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:42:46.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCbalWjZuqbZzQnb8OnTInp95dPi+lDw7m+ncifKowl1voiTUlE7Jjtu0bLpsYvSLwUY/RrsjiBQGk0fmODE5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6037

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/watchdog/orion_wdt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 0e145f762f6f..1802634cc7cd 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -613,10 +613,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		 */
 		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_irq, 0,
 				       pdev->name, dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to request IRQ\n");
+		if (ret < 0)
 			goto disable_clk;
-		}
 	}
 
 	/* Optional 2nd interrupt for pretimeout */
@@ -625,10 +623,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
 		orion_wdt_info.options |= WDIOF_PRETIMEOUT;
 		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_pre_irq,
 				       0, pdev->name, dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to request IRQ\n");
+		if (ret < 0)
 			goto disable_clk;
-		}
 	}
 
 
-- 
2.34.1

