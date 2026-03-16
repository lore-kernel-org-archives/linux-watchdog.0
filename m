Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC81DFFB;
	Mon, 16 Mar 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697550; cv=none; b=bYjPIso1u4x1dEsZrBd3IfDHk0+tUc7v6ibKXg/HlXn3rTjgL1/lIGBfblT5XuDmehmHBP4+6BYeE3MrwqdD7KvO03rgRKFDd5x6XnWoaSFk2k/RrE4lrK+FpLdI9Vyw07ENVi5CWqQWPklsoViMx9FwR0Y7vrkPDzj83UMuSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697550; c=relaxed/simple;
	bh=XLlgVFfQ9O9JQlSYQCkND3/zoyypIH0KhaZJFyAAumU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMcjglzpGSq/JoCJzLWaq+3ZCcyMCwfcXFBeXJTA1WWQb+ObEGef3Bjcpm3bCAxGAZjiplNZCdMB8wZ1gcGHE6Zub7CWphd6R0dx5gUr3xmEQaaRfj/kX/+pxP41CLCzcxAezCwe4yJBZ/fI90RW/ZJ4RglGKc/A313Wuc3zkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=LQbO4TzZ; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="LQbO4TzZ"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GIqLrP1790385;
	Mon, 16 Mar 2026 21:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=iDnRH+IfE7xysddljnmH3hubFNnqL7DXppEE/
	LOZdLs=; b=LQbO4TzZPfWPoVcjzUHjZ8BT6a4YGGJXM6tTAZ9jxo254w/0vYiM8
	9DP3x+gVze4jxuyteFAkEY6vl1y5VIdELEx7+OpdiVp7vP1+VdItf9yFD8xkO36s
	TinX7tjXEHcrPGYYOixUYe7hoy82fzLSeB7cKYXWm4a59YzJyUy+yPDtpxWPLY9l
	E6Cy/EAHN4sc1s5bSBwkprsCDZ3p6MrqH065yf/qQgIiOm7tiXQYqT9sIwkjE5de
	XmZt9slLEYeBtRtZqDx3fxgin8eySBk8rinMn8/vt1Ax+PoNjBsJopA256PEEljb
	r4ZNr7ez2M0tXEzK1UT5FiTDuT0MIo1lg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cxfs28q7t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 21:45:33 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7122227664;
	Mon, 16 Mar 2026 21:45:32 +0000 (UTC)
Received: from owl.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8D10080F492;
	Mon, 16 Mar 2026 21:45:31 +0000 (UTC)
Received: by owl.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id 0109D19025D; Mon, 16 Mar 2026 16:45:30 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter <craig.lamparter@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
        Collins@owl.eag.rdlabs.hpecorp.net, Steve <s.collins@hpe.com>
Subject: [PATCH] Refine hpwdt message for UV platform
Date: Mon, 16 Mar 2026 16:45:30 -0500
Message-ID: <20260316214530.104344-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE3OCBTYWx0ZWRfX0j4DX2bkXuC3
 /YVtGUkecmvq+WWFGz/jKQW/ty6sK4h1mLjzwN5yRRHLMC/deP6QLMtaQVtwMnmiDQhkrTgMali
 h9BSlSONU683cdBhnbdNr7BOf3nVh0fKbZhVKuw3tOA3VNrVMSd5pE7hz47UEO3e3Q2dXINXj5M
 Rd75ys4AC3pUXDZD/yPa6Z78ticcwBm7LGMcQ9dLlG46Le69VAzxJkvlNQqTcuRGiPJ7eK5xc8i
 cMSbqenB1hja2hSoKxlA3tde8FuvDhbV0gpGrbw1D7ucRGbmPj+5TMfGTEsawXVdFTKJjH6ujGJ
 q3lDeJR1lRV9nRlElOoznMsds13MakQbwGSpYTyAvuZK8dA6glSKxX/522U148ILige2Ma2dNrT
 5zJRV7ZwtK/c+y10FcvNS/b4R6OnJ0O5qWzlED9M8oPfCzd0B/Iinrx5UpY8/OVArKLSIF4PUoF
 SSh5l+GB5YG4kmW6JvQ==
X-Authority-Analysis: v=2.4 cv=c5qmgB9l c=1 sm=1 tr=0 ts=69b879fd cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=k7r4yCLl9DVLXMiQTbtC:22 a=MvuuwTCpAAAA:8 a=kcek-6kI0j_o-rl4mPEA:9
X-Proofpoint-ORIG-GUID: qqNgOOKYHmjAOuQkN8bYKflUjd64ho29
X-Proofpoint-GUID: qqNgOOKYHmjAOuQkN8bYKflUjd64ho29
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160178

The watchdog hardware the hpwdt driver uses was added to the UV
platform for UV5, but the logging mentioned by this driver was not
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
 drivers/watchdog/hpwdt.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ae30e394d176..be5d8cbd0818 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -24,6 +24,7 @@
 #include <asm/nmi.h>
 #endif
 #include <linux/crash_dump.h>
+#include <asm/uv/uv.h>
 
 #define HPWDT_VERSION			"2.0.4"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
@@ -158,9 +159,21 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
 	return 0;
 }
 
-static int hpwdt_my_nmi(void)
+#define NMISTAT_EASR	BIT(0)
+#define NMISTAT_EWDOG	BIT(1)
+#define NMISTAT_RTRAP	BIT(2)
+#define NMISTAT_DBELL	BIT(3)
+#define NMISTAT_EMSWDG	BIT(4)
+#define NMISTAT_GPI	BIT(5)
+#define NMISTAT_NMIOUT	BIT(7)
+
+static bool hpwdt_my_nmi(u8 *nmistat)
 {
-	return ioread8(hpwdt_nmistat) & 0x6;
+	u8 val = ioread8(hpwdt_nmistat);
+
+	if (nmistat)
+		*nmistat = val;
+	return (val & (NMISTAT_EWDOG | NMISTAT_RTRAP)) != 0;
 }
 
 /*
@@ -168,14 +181,18 @@ static int hpwdt_my_nmi(void)
  */
 static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 {
-	unsigned int mynmi = hpwdt_my_nmi();
-	static char panic_msg[] =
+	u8 nmistat;
+	bool mynmi = hpwdt_my_nmi(&nmistat);
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
@@ -189,7 +206,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		hpwdt_ping_ticks(SECS_TO_TICKS(val));
 	}
 
-	hex_byte_pack(panic_msg, mynmi);
+	hex_byte_pack(panic_msg, nmistat);
 	nmi_panic(regs, panic_msg);
 
 	return NMI_HANDLED;
-- 
2.43.0

