Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782948;
	b=FkXYqAhw4tnq8Xg9WDHnhsBOf0KT+qOvS3cKsGVtQoAkpFiT5CKlzCJx9knWtuz3wZPR
	 yLdrXQUjqo2FKmSNpJ05BUe8oN0t6Pex6ZUfC0QVQLv2NvKhJjsOvA8rP1PgJMJpnqp6Y
	 scc4+HvzKKXcODoTaRVZrn05HDPW3UopgltHNZb4gtjUWt82EAIki4N23YXDby3yFf91G
	 zNE8jbZfMWQ0A2lMvjGkmZkKPGxCJaRxLs4buqgBPAkNalEwpqf5tZ1Ta7iv5bUSEnRs7
	 Nt27b9nwEeiFrQEbw7KYxwdQagGFsLNOOO7W1xlEuBix8W52jB4DRQs0EDEHUwKx6Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782948;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score:x-atlnz-ls;
	bh=GYDpi5RtVlsK0rkun9mc+EYvL0sZ5wpDL9jLCDRL5PE=;
	b=3Ve7E2P+gDKHc0zH4YpZw7UG8+44S3tULwbuWgoXN0eO4LKjevqhzv9KbRsl+hLAxUE3
	 nCIL95HXiTFdULtruKIZX2nmty4/Ko0Ow2Ny6HhiMNflMCZfnkXvFFl95+2pRRttRuH1R
	 XAFNl1ewX5B2EsdV8p/TgUV4LygVPhQxrTgGZJuHLBdV80VgPiuoWUz6hX2nhDExaXj5d
	 qeGvydAKSdlEnioMFDILJi48+FdN4oiN/1lWadDgJqpUMwVKnttMdxNZR1PUFtiYnppwo
	 OoyfAg8e873vBBWdZA+ZMvA8Jt93FyxQk5gnBGZ97x9NUflwmadv4foE2D/TrUUe+zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=CCRfGykf;
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7839606A31F
	for <linux-watchdog@vger.kernel.org>; Fri, 23 Oct 2026 19:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7839606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=CCRfGykf
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3E6112C034E;
	Sat, 24 Oct 2026 08:15:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1792782939;
	bh=GYDpi5RtVlsK0rkun9mc+EYvL0sZ5wpDL9jLCDRL5PE=;
	h=From:To:Cc:Subject:Date:From;
	b=CCRfGykfWdSCc2Jg8sJK3wQfYlYnKpTuILyDQsu7MBwjvLPebwlrGLeXkA5enQmLM
	 BhNCaz2tt7x4MOtpXOjAWubIlpn1UpmKruQMcwKiZmvREOvvD6Ijfu/ZxMWu4NxROy
	 3+vueRaQY/Nn14u7mJdWhpHfYVFnLZaxPfL57esUFcMOhETxmPXJqtlwbjF2badSBB
	 Ds/KmEwMZvpSEu5eReO7mdkXVMnJw4ekxiRXrQQ6zBErqJnwN1RpEbwKMGYZQdrkWU
	 tWbo1DMK2UXT1UfpGdm3kybdrRPoCNLiHuC44pH1fEqcDwZuZ7jzdwp7mdeEXezHnt
	 IpNRHB8koZf/w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6adbb25a0000>; Sat, 24 Oct 2026 08:15:38 +1300
Received: from carls-dl.ws.atlnz.lc (carls-dl.ws.atlnz.lc [10.33.25.22])
	by pat.atlnz.lc (Postfix) with ESMTP id EE0ED13ED56;
	Sat, 24 Oct 2026 08:15:38 +1300 (NZDT)
Received: by carls-dl.ws.atlnz.lc (Postfix, from userid 1474)
	id ECF9420388; Sat, 24 Oct 2026 08:15:38 +1300 (NZDT)
From: Carl Smith <carl.smith@alliedtelesis.co.nz>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carl Smith <carl.smith@alliedtelesis.co.nz>
Subject: [PATCH] watchdog: octeon-wdt: Add a panic_on_timeout parameter
Date: Sat, 24 Oct 2026 08:15:30 +1300
Message-ID: <20261023191530.327734-1-carl.smith@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=FJW4xPos c=1 sm=1 tr=0 ts=6adbb25b a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=LF8zZQ1HZBz04lkw01wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The hardware watchdog period is only a few seconds, so the driver counts
the heartbeat in software and stops poking the hardware when it expires.
The resulting reset leaves no record for crash loggers such as mtdoops.

Add a panic_on_timeout module parameter, off by default like softdog's
soft_panic, that panics when the heartbeat expires. The panic is logged,
and the hardware watchdog still resets the board.

Tested on a CN7130 board with mtdoops.

Signed-off-by: Carl Smith <carl.smith@alliedtelesis.co.nz>
---
Note: octeon-wdt doesn't support pretimeouts, so the panic pretimeout gov=
ernor
can't be used.

 drivers/watchdog/octeon-wdt-main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon=
-wdt-main.c
index 171b46d780e6..d29a63899847 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -107,6 +107,11 @@ module_param(disable, int, 0444);
 MODULE_PARM_DESC(disable,
 	"Disable the watchdog entirely (default=3D0)");
=20
+static bool panic_on_timeout;
+module_param(panic_on_timeout, bool, 0444);
+MODULE_PARM_DESC(panic_on_timeout,
+	"Panic when the heartbeat expires, instead of a silent reset (default=3D=
0)");
+
 static struct cvmx_boot_vector_element *octeon_wdt_bootvector;
=20
 void octeon_wdt_nmi_stage2(void);
@@ -143,6 +148,8 @@ static irqreturn_t octeon_wdt_poke_irq(int cpl, void =
*dev_id)
 			/* Bad news, you are about to reboot. */
 			disable_irq_nosync(cpl);
 			cpumask_clear_cpu(cpu, &irq_enabled_cpus);
+			if (panic_on_timeout)
+				panic("Watchdog timeout");
 		}
 	} else {
 		/* Not open, just ping away... */
--=20
2.55.0

