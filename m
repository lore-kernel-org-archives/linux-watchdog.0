Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4D32D43C;
	Sat, 12 Sep 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237284; cv=fail; b=JGCOeVxuBOAFgnb8K9BshglkdtogkM780fvDbpeU90I0JjUJHterPaX8QK9n2ubfr/O+62Q+B9Kgk3BPXGMVQ7NQtLona9u9oA8e5lT6J2tRq/ZU+P5zK7nXddE4YvOPUyR2yC3/Sfb4T6woIPp2q8QZzLxGb/XvnR2/LqIL6bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237284; c=relaxed/simple;
	bh=Bxd0fLsx13w8tMMQ9VHucHwlq8Hah6b6pUKWO/X45Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=afrxT/TmTLRoFVo8+LpVEe/03lyndTxZ/O8H+4YcYUHvdxVC8m+VJARUgZRm//yhGGL+B4aTkoIuXMDQyb84SeRZchTxA/CnMu9r6xlTlI0P2uE24GshoKAVfyEu6zdAGGGF3L1Cie6dGgax2lTsj3vqM4J0re1uouYi0MNk9gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqfEN4G5; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqfEN4G5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbREQxS8uyA0bojLjbxQjQy3bz7uqLd2GM6Nyx9HxSwCitNRefG+JH1wOxGYUrS5U1Um0Q5Gcy7o2GBtfrx9lQWHDEAfuyx3EHe6rbxcwHbxUC3BJKz2WlpceGZB5tT1tsQTwGd91XkCUrUUNi9QE6lzdAwHA1p/dpfLUJrjXiOIMMB/pEyv/zEYNAookyBfjO7Nc+12yzpyFlxQpXSM87ys4id4/9Ah6wTsI6F0ExdThn3rEwefbPgo8/l4z6woWLEmQLdhZuoxxFOvFFHk0KO7FSPQE8xyC9yoGak44GeQ4Wn64ranyYVr3bwUNoyd8TVxLU1rmFvzWT40Z45GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp4ynEMi33nAwGQVQfkdq76g/PaxsvumOrIdmc7Fa6A=;
 b=rRPgpkxSmZerqLpHWxxBB9CfC6XsJUWk8JC+h+igYb+yQy5ZQBZg9jFCL9QlOreL5Gemy3IKG3xKwhN4TwV8ViplFP/3Cq0eukkZPbXmjgOYjdYZl4Ymf7qzG2SAH+q60mRAqVI/GiWsxgvOV8hIQaskQnVStSn4W+087C+c8LIGTo9rmIMz0/cYAgZviWw9WvE43IxJ2QFUlqZ7BIzR+6olfpSaR3vRibjtBIkL3mV3vXbNR2k+nG1R4NI9lW73ewIYoxq0+INrxw68EOz0LcueACz/Ue3779T5kkHjDNPeStRdLQUY+ja50Vnhsobhc8KSX4DRtYqwWwYunWVFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp4ynEMi33nAwGQVQfkdq76g/PaxsvumOrIdmc7Fa6A=;
 b=cqfEN4G5SkZnDh7nH1rjfK8Wgp7B8sE8DDhqBROJN07TZoOU1v3mCJbe/1q7kd92BA6F1nS9HjTVPKqAo3oWcWLz0ZCvOaLs4QrBc8POz96SLLtUDClw3OS33O3hYCdx/lhxqZCg8Qg89QMOQDEaeH8JZzexcqO+DmAd6j3DMeHzIBXy+fIDWGrXTorVFR916My8JSYHidhWndNjSSyQmaffOyh81gJdwU3fp1NW8g824QAR2ePG+fX+7XedgE3C3cDGbb9o1msPSBd4tBNz/5zS2tu8EGQNH3YdIY7XlNXRLNJLdj2Bj+9FOrLYjEB8k1hMpA74L1pFL/h6AMeYhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 18:21:14 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::cb31:7ebf:51e3:d9f6]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::cb31:7ebf:51e3:d9f6%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 18:21:14 +0000
From: David Cemin <dcemin@nvidia.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH] watchdog: sbsa_gwdt: stop the watchdog across the whole system-sleep transition
Date: Sat, 12 Sep 2026 11:21:07 -0700
Message-ID: <20260912182107.1156221-1-dcemin@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:806:127::26) To CH0PR12MB5089.namprd12.prod.outlook.com
 (2603:10b6:610:bc::8)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: bd82005b-e1c3-4472-64fe-08df10faa10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|5023799004|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nS4IV8o2+sj0/SaCY9R5LEs/YzAnuLOvKGn4pj61Lmh6TIgezSstPbrvQtKU6HsbCR0MP8OqmBTphv0PbfMHjSGxPNeNPc3gasE8S1Hs7sCKbO+47PoPifASWz/SIRwrX8gigPc/CRqxZoyOPqYMfXdbmF4JYwqzPOY8uze7a5OD/fAw1EBC+tkhDk4F3nV3o0cWFx1F1F1oSPS04HGRSUoAJ5TT0TiWVa1R5ElmSK91gNHAIHBN8uUXYj4gDisS/3S3zg19mEi/3kuzgRXYOyFsD6zTAVeFkaa/SeZ0UGByyyGQFjLcJ71FU2lTIZMPM8cKztuxdWXHQ6ofhRwKiin0JAZ3n4UMjisU041VclgmOrpymxaHfz1kbkSw3y7oS51cW8Iq/pqcquXryLNg5/inu5YEklU1UeMPj1qny1UUk1T1osrNe8cpvunMxhUpdpUSoKyBd987FnTj3RVdJ3b3JBBnrxS6BoEidH5D+fMnqZpmUWPcOzfgCIvubtN6i/gSPhgrigpo1VOL7loRFJuG7uffa1ewrXnIHTTdSlrR9qcFT1yl5CCCee6EJWVpg/tDDAXhOO8wxGG0dvDTFkEIZeskM0d51OoTPPHoHkJmlV7wdvleQi0kZRQYhC+QCpfYzGszLQvJA4AmNfxdkutpKTm15xWdJ/O4+1nrA00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7mv91XDrqbFjnlh7wSPm6A+paG0t5/UvJ6rCbsNXb1xx2R3TigOcazTMpNO?=
 =?us-ascii?Q?NBwAbNRiFU7/IIo+aNtnl3vEoGshdcoJLHK/BTOxlF0zZlKPAX7enK8KU1/P?=
 =?us-ascii?Q?VrqCvMK3SA146AS4KB6iBEjP1cCLxNR9u0ehN3Lf84cxFxds6zzjt+8Aerm3?=
 =?us-ascii?Q?n/c6boKEDt2rI/VeIyCJeMj2FpUc0pm/eMSujXtV6mT1ddWwdZotWHERPgR6?=
 =?us-ascii?Q?So5SgnZZVQMIvgPhbWZpwDElkYKG5dPzxzrC0D98Ptpb6kwvh/bKGqyDOD/i?=
 =?us-ascii?Q?6NCOrBAR852xa3uHNYV8mzmNyZqLzSP3NMJE6LkRM9+Uj2NJ0iOucj3v11i3?=
 =?us-ascii?Q?C247PgPEvm/RRxZJquXYSnLyZJ+Lvcq9PM9D9UNAXxw/lnlpAEVKOTBcp2TJ?=
 =?us-ascii?Q?HKSEW9J0e9E6SO6jhHZVEnoCZ3EShTsNqTtbKas5SiNvkhSOkf1FAAOSCa+K?=
 =?us-ascii?Q?43UquWtLLayxxkRXYfqiXRp3Z2FgIjJTpAMlWFAOlEnNxgXnESl0cehjpVWL?=
 =?us-ascii?Q?/CQ/TsI+COXYceGqJQna8Pa0e1yxMocwIT4Rga1uBYEoSQIqKj93CvvPLeMy?=
 =?us-ascii?Q?48ksZIasmb1cZ+4gpEu+S2AQGMZJF0s+x7u4g8rIt43KSeM8PRk6p0cW7+7Y?=
 =?us-ascii?Q?xeL6PRwF3N2RNZhvCkPABWuf+i+o26ShRxj+usFo2A2kDyetPm/D52MOm8n6?=
 =?us-ascii?Q?6T1HDmnK3wnMsZ9Gm5XVGujW/9/egSYw87pUMq2q+M7t+/WJlrEzT727f7Wy?=
 =?us-ascii?Q?/oboFhzdsVY2l3bSi22RYFIZ6kaCWDhOlWMZxyB1ON3ZlWclmMYxMnvOsPfG?=
 =?us-ascii?Q?RBt2oeLKDeyG9UWtZtCU+lVjZ+1hHm1mVxAR4w8DD8oT59nOSJdM6egO30CH?=
 =?us-ascii?Q?Fx/Jw8uySPNH27ZCxOapWV874PJNQWAPNA4VTcONS1g+DTZ3KBoePvvtgFIf?=
 =?us-ascii?Q?bOhSDqtPPDPtM1BCTnTYuxxQE/jkCok1deXkMVwaETuoPOkl+HcE9BL3+6xo?=
 =?us-ascii?Q?STZkUszoC0nciP3ewXRZMEdDQf4GtK8CQmpKLjeKypZ8qHgajHwi014SdPMC?=
 =?us-ascii?Q?J1q+85V4sHe9Az8164nHtvCgp/sbfjF2hgelh+r+Esa9x9dSrwUWacv5LusR?=
 =?us-ascii?Q?CkIUFlVwRwTL6KRlrs6tj+COTO7bo9Py3vesgALObLxqEQvlnMnFNP/ruHgJ?=
 =?us-ascii?Q?ykZa1sokpAsGcDsMvsvCqrEnUkFq8CovgmyQbBhxpoxL9Ert94QeTA0MT9DI?=
 =?us-ascii?Q?eAtsC+UvkpBaOrKzCIZD9Bra797pXa+zAvA2DKKqZheo2eD3AZl+NDNt0YNe?=
 =?us-ascii?Q?xuKBQTKHtR1YopZL3cDvftMgYH9/Bfetqzl9Oj2VPK2b1wEDfubCKhyGZ+A9?=
 =?us-ascii?Q?DSIc6Lp+dlYdfQKycaGK02V9Y1BllEpEGT+KxIuQzxyTDxNA2fBIt1FkDkZX?=
 =?us-ascii?Q?u/IMYwF8hpRLnsaUs76Pa+NM7EAVXOgfopSH9fk7OOGUkYg9N2uhvO2xmXGt?=
 =?us-ascii?Q?I9Fspnax+UWV7pJ3rSjx655tvrsQh1t9LzAWXKk/G8t8OCC49OF67HpNAIpt?=
 =?us-ascii?Q?pudSQg6lMA0JCSD1bgRrrrKqcm3FUywwu/N5UXOFX8mpwC824oycBuuIwS5o?=
 =?us-ascii?Q?okids+svW56GGXkzpno0MRrCLgOG6KgyeCADr98PsC0d+dTHrF1HjyMJwnOM?=
 =?us-ascii?Q?phb/zK+uLPiSrhaIfA8hecVVraQPYDWt7q48I9XK+f6oYGdF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd82005b-e1c3-4472-64fe-08df10faa10d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 18:21:14.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0lL5dPDn9n//o3lgN+IysiggqZ/7FRsXUKezBDnb/2xkpAFcrGlS09swNY5T9PTWGb593333jNIwAoPTCsfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

The driver stops a running watchdog in its own device suspend callback
and restarts it in its resume callback. That leaves the watchdog armed,
with nobody refreshing it, for the entire early part of suspend entry:
userspace freeze, kernel thread freeze, and every device suspend
callback that runs before this device's own. The same window exists at
the tail end of resume.

When the watchdog is already running when the driver binds (started by
firmware, 10 s default timeout) and any device stalls its suspend
callback past the timeout, the watchdog resets the system in the middle
of suspend entry. On an arm64 laptop platform this fired on about 7% of
suspend attempts in a randomized suspend stress run (9 resets in 124
suspends, with the watchdog reset status set in the SoC's reset status
register). Two elimination runs confirm the mechanism: the identical
stress matrix with the watchdog stopped produced zero resets in 118
suspends, and with the first version of this change (notifier plus the
original device callbacks) applied, zero resets in 198 suspends across
four runs, where the baseline rate predicts about 14. The version here
keeps that mechanism, removes the device resume callback and adds the
locking described below; it went through a further 120 suspends (60
s2idle, 60 S3, randomized order, console recorded through every entry)
with the watchdog armed from boot and zero resets.

Stop the watchdog from a PM notifier at the *_PREPARE events, before
tasks are frozen and device callbacks run, and restart it at the
PM_POST_* events, after everything has resumed. The driver state (armed,
stopped for sleep) lives under a lock shared with the watchdog ops, so a
userspace stop or magic close after thaw cannot race the restart, and a
start requested while the transition is in progress is deferred until
PM_POST_* instead of arming hardware nobody can refresh; the transition
is recorded at *_PREPARE whether or not the watchdog was armed at that
point, so a start between *_PREPARE and task freezing is deferred as
well. The notifier is
registered before anything can arm the watchdog and its failure fails
the probe. A suspend-only device callback remains as the final guard for
a device whose probe overlapped the *_PREPARE event; it has no resume
counterpart, so nothing re-arms the watchdog during device resume,
before PM_POST_SUSPEND. The initial hardware state is adopted under the
same lock, so a firmware-started watchdog discovered by a probe that
lost the race with *_PREPARE is stopped at once and armed again at
PM_POST_*; the stop path is idempotent so the device callback remains
an effective fallback whatever the ordering.

Fixes: 57d2caaabfc7 ("Watchdog: introduce ARM SBSA watchdog driver")
Signed-off-by: David Cemin <dcemin@nvidia.com>
---
 drivers/watchdog/sbsa_gwdt.c | 191 +++++++++++++++++++++++++++++------
 1 file changed, 159 insertions(+), 32 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e04d42cc7774..399a8bcb3c6f 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -46,6 +46,8 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
 #include <asm/arch_timer.h>
@@ -87,6 +89,13 @@
  *			indicate whether to adjust wdd->timeout to avoid a race with WS0
  * @refresh_base:	Virtual address of the watchdog refresh frame
  * @control_base:	Virtual address of the watchdog control frame
+ * @lock:		Serializes the watchdog ops against the system sleep hooks
+ * @hw_armed:		The watchdog is logically running (started by firmware,
+ *			or userspace); the hardware follows it except
+ *			while a system sleep transition is in progress
+ * @sleeping:		A system sleep transition is in progress: the hardware
+ *			stays stopped and hw_armed is applied at PM_POST_*
+ * @pm_nb:		PM notifier stopping the watchdog across system sleep
  */
 struct sbsa_gwdt {
 	struct watchdog_device	wdd;
@@ -95,6 +104,10 @@ struct sbsa_gwdt {
 	bool			need_ws0_race_workaround;
 	void __iomem		*refresh_base;
 	void __iomem		*control_base;
+	spinlock_t		lock; /* hw_armed, sleeping */
+	bool			hw_armed;
+	bool			sleeping;
+	struct notifier_block	pm_nb;
 };
 
 #define DEFAULT_TIMEOUT		10 /* seconds */
@@ -244,12 +257,33 @@ static void sbsa_gwdt_get_version(struct watchdog_device *wdd)
 		!action && (impl == SBSA_GWDT_IMPL_MEDIATEK);
 }
 
+static void sbsa_gwdt_hw_start(struct sbsa_gwdt *gwdt)
+{
+	/* writing WCS will cause an explicit watchdog refresh */
+	writel(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
+}
+
+static void sbsa_gwdt_hw_stop(struct sbsa_gwdt *gwdt)
+{
+	/* Simply write 0 to WCS to clean WCS_EN bit */
+	writel(0, gwdt->control_base + SBSA_GWDT_WCS);
+}
+
 static int sbsa_gwdt_start(struct watchdog_device *wdd)
 {
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	/* writing WCS will cause an explicit watchdog refresh */
-	writel(SBSA_GWDT_WCS_EN, gwdt->control_base + SBSA_GWDT_WCS);
+	spin_lock_irqsave(&gwdt->lock, flags);
+	gwdt->hw_armed = true;
+	/*
+	 * While a system sleep transition is in progress nobody can refresh
+	 * the watchdog: leave the hardware stopped and let the PM_POST_*
+	 * notifier arm it once everything has resumed.
+	 */
+	if (!gwdt->sleeping)
+		sbsa_gwdt_hw_start(gwdt);
+	spin_unlock_irqrestore(&gwdt->lock, flags);
 
 	return 0;
 }
@@ -257,9 +291,12 @@ static int sbsa_gwdt_start(struct watchdog_device *wdd)
 static int sbsa_gwdt_stop(struct watchdog_device *wdd)
 {
 	struct sbsa_gwdt *gwdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	/* Simply write 0 to WCS to clean WCS_EN bit */
-	writel(0, gwdt->control_base + SBSA_GWDT_WCS);
+	spin_lock_irqsave(&gwdt->lock, flags);
+	gwdt->hw_armed = false;
+	sbsa_gwdt_hw_stop(gwdt);
+	spin_unlock_irqrestore(&gwdt->lock, flags);
 
 	return 0;
 }
@@ -288,12 +325,101 @@ static const struct watchdog_ops sbsa_gwdt_ops = {
 	.get_timeleft	= sbsa_gwdt_get_timeleft,
 };
 
+/*
+ * Per-device suspend/resume callbacks alone would stop the watchdog only
+ * once this device itself is suspended, one of the last steps of suspend
+ * entry, and restart it during device resume, before tasks are thawed. A
+ * watchdog running from boot (started by firmware) would therefore be armed, with
+ * nobody refreshing it, through task freezing and every other device's
+ * suspend callback on the way down, and again from device resume until
+ * userspace runs on the way up; anything stalling past the timeout in
+ * either window resets the system.
+ *
+ * Own the transition from a PM notifier instead: stop at the *_PREPARE
+ * events, before anything is frozen, and restart at PM_POST_*, after
+ * everything has resumed. The driver state (hw_armed, sleeping) is kept
+ * under a lock shared with the watchdog ops so that a userspace stop or
+ * magic close after thaw cannot race the restart, and a start requested
+ * while the transition is in progress is deferred to PM_POST_*. The
+ * transition is recorded at *_PREPARE whether or not the watchdog was
+ * armed at that moment, so a start between *_PREPARE and task freezing
+ * is deferred as well instead of arming hardware nobody refreshes. A
+ * suspend-only device callback remains as the final guard for a device
+ * whose probe overlapped the *_PREPARE event; it has no resume
+ * counterpart, so nothing re-arms the hardware before PM_POST_*.
+ */
+static void sbsa_gwdt_sleep_stop(struct sbsa_gwdt *gwdt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gwdt->lock, flags);
+	/*
+	 * Idempotent on purpose: the *_PREPARE notifier and the device
+	 * suspend callback both land here, and a probe that adopted a
+	 * firmware-armed watchdog after *_PREPARE relies on the second
+	 * call actually stopping the hardware.
+	 */
+	gwdt->sleeping = true;
+	if (gwdt->hw_armed)
+		sbsa_gwdt_hw_stop(gwdt);
+	spin_unlock_irqrestore(&gwdt->lock, flags);
+}
+
+static void sbsa_gwdt_sleep_restart(struct sbsa_gwdt *gwdt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gwdt->lock, flags);
+	if (gwdt->sleeping) {
+		gwdt->sleeping = false;
+		if (gwdt->hw_armed)
+			sbsa_gwdt_hw_start(gwdt);
+	}
+	spin_unlock_irqrestore(&gwdt->lock, flags);
+}
+
+static int sbsa_gwdt_pm_notify(struct notifier_block *nb, unsigned long mode,
+			       void *data)
+{
+	struct sbsa_gwdt *gwdt = container_of(nb, struct sbsa_gwdt, pm_nb);
+
+	switch (mode) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		sbsa_gwdt_sleep_stop(gwdt);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		sbsa_gwdt_sleep_restart(gwdt);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static void sbsa_gwdt_unregister_pm_notifier(void *data)
+{
+	unregister_pm_notifier(data);
+}
+
+static int sbsa_gwdt_suspend(struct device *dev)
+{
+	sbsa_gwdt_sleep_stop(dev_get_drvdata(dev));
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sbsa_gwdt_pm_ops, sbsa_gwdt_suspend, NULL);
+
 static int sbsa_gwdt_probe(struct platform_device *pdev)
 {
 	void __iomem *rf_base, *cf_base;
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct sbsa_gwdt *gwdt;
+	unsigned long flags;
 	int ret, irq;
 	u32 status;
 
@@ -318,6 +444,21 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	gwdt->clk = arch_timer_get_cntfrq();
 	gwdt->refresh_base = rf_base;
 	gwdt->control_base = cf_base;
+	spin_lock_init(&gwdt->lock);
+
+	/*
+	 * Register the sleep hook before anything can arm the watchdog, and
+	 * treat its failure as fatal: without it a running watchdog would
+	 * survive into system sleep with nobody refreshing it.
+	 */
+	gwdt->pm_nb.notifier_call = sbsa_gwdt_pm_notify;
+	ret = register_pm_notifier(&gwdt->pm_nb);
+	if (!ret)
+		ret = devm_add_action_or_reset(dev,
+					       sbsa_gwdt_unregister_pm_notifier,
+					       &gwdt->pm_nb);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register PM notifier\n");
 
 	wdd = &gwdt->wdd;
 	wdd->parent = dev;
@@ -347,8 +488,20 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 		dev_warn(dev, "System reset by WDT.\n");
 		wdd->bootstatus |= WDIOF_CARDRESET;
 	}
-	if (status & SBSA_GWDT_WCS_EN)
+	if (status & SBSA_GWDT_WCS_EN) {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
+		/*
+		 * Adopt the firmware-started watchdog under the lock: if a
+		 * system sleep transition began between notifier registration
+		 * and this point, keep the hardware stopped now and let
+		 * PM_POST_* arm it, like any other start during the transition.
+		 */
+		spin_lock_irqsave(&gwdt->lock, flags);
+		gwdt->hw_armed = true;
+		if (gwdt->sleeping)
+			sbsa_gwdt_hw_stop(gwdt);
+		spin_unlock_irqrestore(&gwdt->lock, flags);
+	}
 
 	if (action) {
 		irq = platform_get_irq(pdev, 0);
@@ -398,32 +551,6 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/* Disable watchdog if it is active during suspend */
-static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
-{
-	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
-
-	if (watchdog_hw_running(&gwdt->wdd))
-		sbsa_gwdt_stop(&gwdt->wdd);
-
-	return 0;
-}
-
-/* Enable watchdog if necessary */
-static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
-{
-	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
-
-	if (watchdog_hw_running(&gwdt->wdd))
-		sbsa_gwdt_start(&gwdt->wdd);
-
-	return 0;
-}
-
-static const struct dev_pm_ops sbsa_gwdt_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sbsa_gwdt_suspend, sbsa_gwdt_resume)
-};
-
 static const struct of_device_id sbsa_gwdt_of_match[] = {
 	{ .compatible = "arm,sbsa-gwdt", },
 	{},
@@ -439,7 +566,7 @@ MODULE_DEVICE_TABLE(platform, sbsa_gwdt_pdev_match);
 static struct platform_driver sbsa_gwdt_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.pm = &sbsa_gwdt_pm_ops,
+		.pm = pm_sleep_ptr(&sbsa_gwdt_pm_ops),
 		.of_match_table = sbsa_gwdt_of_match,
 	},
 	.probe = sbsa_gwdt_probe,

base-commit: 841e384b841a3d89c50b4b2d6c5bb6abab1a7e39
-- 
2.55.0

