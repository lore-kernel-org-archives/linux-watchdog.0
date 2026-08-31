Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8847124D;
	Mon, 31 Aug 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190617; cv=fail; b=oAb3poLCCqjg2lkJ9batuWhFmj10k4uU5OiorbNtqy4Szy4swJvQ3WKue3koWQzdyC22CXGdDzkys9g0p0b08dlAOHcxqIsmS7Cet318jcV/+9UpuxLcAG4wnZGWdeJUbtNoR1AlI43+xKo+F/pXhFCS5rM6hgfYMQsreoTBF/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190617; c=relaxed/simple;
	bh=GEJI5NSZ11SDrkgIqxlwS7oOS4Hr0OKROAsVJgMWfCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=syNR2CEMz+Hn4A/SuT670O0QomE/HQfOjnIlV3MO4ISi4FI2uAFcNgfABjtgNJNxEhB31Xyi2hBkHLQMilepPrlBgUykO0EwLcXxMEcd1+gcmCh3BsbrX3w2GcwQWqD2zJ+Dc11VXBl8a7LaGXto6AbSgnAMmOPQhHAvJ9zel6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Jxy4BKzk; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Jxy4BKzk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVWhQrFbKX59BreDDXcsJlLY7msMYRN6kjMdqCqObDX/tHZQBTcg1ZRqpIy7AHmnePEGJYxaeZkTH45/ADYbL8QKHTRhW9ieMFvOVU+PqwRu+A2bFjDdlJ8aFRzwZn0S4ZMzq+ePh9TeNckDuF5Z6KUvgjVvPDKmXaO/cCDZ7GAoZdAUzVNrGECqG6tldy1N8t6iSUnPgh2drHRnYu7e7B1HNCbmtSWahK9UCYNrRL8OV69LCMjREbjp/n82Jo+mphrmRkg1VCAx2+S2w4lBzXNgniBIn5tjnXIDsxmoRmTqZ9MYTC+GW4cdKrgOZw6OZ7T2CpW+XwsIuYpstc0zDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6fq8FFUhqTh6OxO/hbh+tslolTU6uMjlpwMj/rFrSg=;
 b=S4x7UyU1QbMCw67PbTQskdGbRbifjh8o5PQ5D+5xGqGcygFFYG7R6WIrIgfI9l42m3uJ2EOkhM3EadDSpCAE5tFj/OIqcqgAlwKqfVo3BMRkWyg+z9Pfqkd7P7Zw8bAgWdKVrkStd9oqasEPpXun7IktxROd1n7OvjYrS+dLsLDZMzWOaNGxnVW+iYEuOnXsSKMhLMTVNqQUGhNq4HE9uTn13y0Mo53X+rpljsTBIG/x9Bcld0v4mAUtgicqh50QZGw6OXFKDbCO3oh4FIIdWeP9XkX6ZR9V4mbHkcyie5+liW7jY51jL0WFSdX1Ug8NK859HFSOb0nOuGerdNi0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6fq8FFUhqTh6OxO/hbh+tslolTU6uMjlpwMj/rFrSg=;
 b=Jxy4BKzky5vtuylFv/AY/4mCU4TmnQiVAhFbh8j0x7S0mc7QLg1kSY7fZ4Mo6blKBQGgaq6F1avpDHQLCU/X3u6izaf5D9AY1y2JS+cuorkGXtznChPwYDu+i8WmWL6vZs7UAh+5x3JtLO/zc/BYZIzIlO65ZoG8Q9YJUUFZch2hRrCm9WR3nqliFq6/spV3RlGZmJZ7Xg06COtGk98p2R9ABMBynY0qpSrl5M/cmP8IUPvxds/57F35LheHHHEU5RdPvyG6WCI5Stjud+SAyMiWu1rlrUgfAxlYvy6J9TvSr8/WT8QU83GWYZ6mY6VM+Uy1vfodrh1J7w83KWs2YA==
Received: from DU6P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::17)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Mon, 31 Aug
 2026 15:36:49 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::88) by DU6P191CA0023.outlook.office365.com
 (2603:10a6:10:540::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 15:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:36:48 +0000
Received: from ENXDAG1NODE4.st.com (10.75.129.197) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 31 Aug
 2026 17:34:07 +0200
Received: from localhost (10.48.86.45) by ENXDAG1NODE4.st.com (10.75.129.197)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 31 Aug
 2026 17:36:47 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: <linux-kernel@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] MAINTAINERS: Update URI for watchdog tree
Date: Mon, 31 Aug 2026 17:36:46 +0200
Message-ID: <20260831153646.396038-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE4.st.com
 (10.75.129.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|AS8PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a605c65-f16d-4966-7e6f-08df0775abf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tE7w7RD+CzOI1vRWCaB2ZWkPfjFZc0sKcHpeGc4rEyqo1QN2yVMZxSE2VL0XBt0I0reKIaII8FExTdKJ+ne9RpUCbK+K1OnG5Jx6CEel726oje1cvJTI7xnOuNWfwQDnft3iDCqjfvUf5FP8QLwjnuEul8MsTDVYPuWn5tiumgCzkVrR0cGqsRD+nQuGZHFzmEds9WaUCgIBYOAj9GT/+FwrAJqzhTaMRm1lfqulHgqmt0/uJjmFvGDl9SmQNyEZrYzYcdSoKDNA2Qa6Arc0xTcWduL3yPDI3kkNGh4T4WFzcQGaBs8t69azFxs1BQGzVRaWt21R1rWHG3B9NpAIySszjDUV/dZH+QjdKlgBfDE84gthVmKuC1+xmDULHPaW8oM5m9vMsRb5GU/CKGQ04o3UZCJuqXNz1qLNdaLxK5SG3Q9jI0Mb1knFqwgsf0g1m5OkMvvCkyjZ2sbKgR6pOpNwZFojCYnlryrzlv4MlfQWP2GpCcfNeRJu1caLhY2iyW4cbTF4NnnCQ5GzuDDq3peDmp9+mrfSjIu81AD04v4WrRYB0zGsw9xN8LqH1FLySbzc1wh6OzHh66aeXgoA4Fi7cUEgtsZGpU0IhIPYPkCp+Rdv3zV1jE9KHfl2H4IHBioszsMiRbMcUTcEqe0LdQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.88;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OTLawAkaRT6SgyuuW8TMTR2XuQL3Z3ULdkgBggZdT+W6IGGRCvSeayfVNPLCahqGTUV2+UC+QkZRRhNAjID2jiIP177z9YO4e4rjYI+Om/9rOODChRCZzrXBT11tGDWzAPc8/vlrWDLhVCvNJhxpaknfLsVBZriAf5+2zr+m6A33qV2VeDcLFIyMDRVCP8899QNG2x2NfPvcP3z1qcHIhJiVvbBdAP7XL5Y2Em66KlTIBZYBtsPwGL1IUKWZ58AJRTLsYMNKq9PSXTq1nd33gQ1C+oXdL8Uup1Ke0/kq50I49xq/8QoekudUguTVBZjtisSFrAkbSeULLJtqHBOF45nrJE0IL/oTYQa1g3yRjocEbZodv3tiskL56V0VE0s6yArAY87hY9xtSmiwU99l8paf1w1o8oLxdslts5HKZJCNkDD38jfNsKc5RFiRNLEE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:36:48.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a605c65-f16d-4966-7e6f-08df0775abf6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.88];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664

The old git repository
	git://www.linux-watchdog.org/linux-watchdog.git
is not accessible anymore, while the development of the watchdog
framework is currently handled in git.kernel.org by Guenter's
linux-staging repository.

Update the URI.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c9..5e0468e532577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29357,7 +29357,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 W:	http://www.linux-watchdog.org/
-T:	git git://www.linux-watchdog.org/linux-watchdog.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 F:	Documentation/devicetree/bindings/watchdog/
 F:	Documentation/watchdog/
 F:	drivers/watchdog/

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.34.1

