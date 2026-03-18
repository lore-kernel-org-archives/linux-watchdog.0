Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368F3B27DB;
	Wed, 18 Mar 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849027; cv=none; b=Aqa5fF1Uip37WuIjKd5X2tIGJbSus/NecyZfPlSotjrh69PuEqSsLs9YK1mh0JU2kt+aw955hnPjf0vQ3csk3/6ys8xCsLAn0L/HsJTKq9iEA95o8qCW57Gn1VZTrFG+5AVVof9reGBbM++L8N/ecmpC2a8sHDfSoyJ9hYnBd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849027; c=relaxed/simple;
	bh=g9T63RueJMtifxJC6JA8xO9pL5onjGCiY86evAhx4pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4HFEEvR3OEGmTwEhzSWwAuJ4lZuEXich1tL+x4gq/CcFN6EQ4o1Bcw4mzvToTVzm/Y+MDRlJ3yuxV4UFwQOVnI7wl7rk6nFmZzUrft9QnicsTOnJSVYAzAxjuS0p7c47ROmqFXYXOHg2/VPhi0Xb2g2S6PjjqmFZ347euo2d5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=P4D3Wdi/; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="P4D3Wdi/"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ICB1WE2605362;
	Wed, 18 Mar 2026 15:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=JyG9FK0RWFUTISUE7baEiaUuq60CioyhLNNb8
	yloctg=; b=P4D3Wdi/8jxVHJ0g2NN1G+JId6E9pNcoq//JbS5aLXJOir6+TZIJk
	yIXLlYOOO7ZcO9NwUpUUwnitjlEkbRCABjHvqyGHgyTqdSjiyNFasSYIIALHZiJO
	HvigRPRHcprbzQOqxHv5F1YA6gNqpTQyNttHZIQVhq1xsye9eh62m3nwQYSjhx3r
	CAx9EwEJJ5vch4ZUu0ELsp+GCr/qozweCz3H93DxmkyAjQ5KJDLGNRDnuu++rVwk
	22XAwZAw1frMiiu6n7R/vRP+A6hL3Afs7BZsQJfyqHoQPT61WceHksU5I62z9aXm
	PztnOLqZhbqlA83t6qnRdrXqPSlzlNvuA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4cyufu3126-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:50:07 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 03966802B97;
	Wed, 18 Mar 2026 15:50:06 +0000 (UTC)
Received: from owl.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 3007E805E66;
	Wed, 18 Mar 2026 15:50:06 +0000 (UTC)
Received: by owl.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 6EBEC27BFFA; Wed, 18 Mar 2026 10:50:05 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter <craig.lamparter@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
        Steve Collins <s.collins@hpe.com>
Subject: [PATCH v2] watchdog/hpwdt: Refine hpwdt message for UV platform
Date: Wed, 18 Mar 2026 10:50:05 -0500
Message-ID: <20260318155005.90271-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R2iSKvZ7spDC7e-uGTQoHvIXfUKw_oUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNSBTYWx0ZWRfX9kVDNjTxgdXF
 oBOw744tdTHM37CItVtIx6lVy9NOR9nr+6D5XTxjxu5+VtGmJSYW4708EklyNcMpdoq75lRkIn8
 IAThmqBCAf4A+MXVKMkpK28hOcuQJlrFT8HELap800JI1EF0INQOC2lhsMHkQBglglC+qyhbs3g
 2hfqpIGwZAdKSOOEU94ZvTePvqbIiwTXSpQyMRsqIW2ohxCBh30BX978rCiA4G66nogLG7Rk4hJ
 hr79GrlgKWs5Jk8yJLmVv/MNjvvxr5+MoR/6C3NX2L56PiQvh6BABZ5ugeWYcxy4b84tax3aLMs
 mXiRBIlQUEoshPlW94zx5S0Jnontpyw7nWNb/Q4Ahh9Ith6V57zzIkeXuxaga2jU8V0qJvakgn2
 1LeCXtABxu0wgNULAYOetKH6ZrC0ghWKrzP2VlC2j6PB/S27OJSDdWDSvS/s1B0fshY+pb5Hs8H
 NtbnZqb7sueINN/82dw==
X-Proofpoint-GUID: R2iSKvZ7spDC7e-uGTQoHvIXfUKw_oUN
X-Authority-Analysis: v=2.4 cv=dZyNHHXe c=1 sm=1 tr=0 ts=69bac9af cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
 a=kcek-6kI0j_o-rl4mPEA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180135

The watchdog hardware the hpwdt driver uses was added to the UV
platform for UV_5, but the logging mentioned by this driver was not
added to the BIOS.  When the watchdog fires, the printed message had
the administrators and developers looking for non-existent log files,
and confused about whether a watchdog actually tripped.

Change the message that prints on UV platforms so it doesn't send the
user looking for non-existent logs.

To aid in any future debugging, include all 8 bits of the NMISTAT
register in the output, not just the two bits being used to determine
this was "mynmi".  And provide names to the bits in NMISTAT so the
code is easier to understand.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

v1 disucsion: https://lore.kernel.org/all/20260316214530.104344-1-steve.wahl@hpe.com

v2: Fix subject line; remove hpwdt_my_nmi function, and inline what it
formerly did, reducing complexity. This addresses comments from
Guenter Roeck.

 drivers/watchdog/hpwdt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ae30e394d176..ba08189937ec 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -22,6 +22,7 @@
 #include <linux/watchdog.h>
 #ifdef CONFIG_HPWDT_NMI_DECODING
 #include <asm/nmi.h>
+#include <asm/uv/uv.h>
 #endif
 #include <linux/crash_dump.h>
 
@@ -158,24 +159,31 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
 	return 0;
 }
 
-static int hpwdt_my_nmi(void)
-{
-	return ioread8(hpwdt_nmistat) & 0x6;
-}
+#define NMISTAT_EASR	BIT(0)
+#define NMISTAT_EWDOG	BIT(1)
+#define NMISTAT_RTRAP	BIT(2)
+#define NMISTAT_DBELL	BIT(3)
+#define NMISTAT_EMSWDG	BIT(4)
+#define NMISTAT_GPI	BIT(5)
+#define NMISTAT_NMIOUT	BIT(7)
 
 /*
  *	NMI Handler
  */
 static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 {
-	unsigned int mynmi = hpwdt_my_nmi();
-	static char panic_msg[] =
+	u8 nmistat = ioread8(hpwdt_nmistat);
+	bool mynmi = (nmistat & (NMISTAT_EWDOG | NMISTAT_RTRAP)) != 0;
+	static char panic_msg_default[] =
 		"00: An NMI occurred. Depending on your system the reason "
 		"for the NMI is logged in any one of the following resources:\n"
 		"1. Integrated Management Log (IML)\n"
 		"2. OA Syslog\n"
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
+	static char panic_msg_uv[] =
+		"00: A watchdog NMI occurred.";
+	char *panic_msg = is_uv_system() ? panic_msg_uv : panic_msg_default;
 
 	if (ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
@@ -189,7 +197,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		hpwdt_ping_ticks(SECS_TO_TICKS(val));
 	}
 
-	hex_byte_pack(panic_msg, mynmi);
+	hex_byte_pack(panic_msg, nmistat);
 	nmi_panic(regs, panic_msg);
 
 	return NMI_HANDLED;
-- 
2.43.0

