Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116990;
	b=rBNJxU77nlJYpDBc0Up+PM5L8kQBnCOhC+pfj05EPEeY4358eDDAOKBV6Gg77XMXEQT3
	 62/ssvhYqfqJKRWy08YtKe6lPynmwlNvfPpClXSPqxNXc07D/TtyrnPoYd/3oe/I/2Vde
	 5wQ5YKA8o5ULXPL2EANB4wnRtWC3Udhz8c67ZzvTvJ2IGuLDBcIl/rVYDWkXgEigKZ61L
	 VT9dFrm0hZKjSJqHTGOeG8KHW5czQYMO7NfwI7xXkv4Or1bnUpD78hFQL9jwIAeFV4roV
	 swwu18OO77j2ciD9fD+zPWc5q0EGQVhAXvips3iM2Cb3nnVnZ2DThnvV5vuwRZkqdJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116990;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:
	 X-Source-IP:X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=P/10AHWvTXXg1IeFeEr3jCvHIaauZayPfb4XOkRgwq4=;
	b=MaakIeXUy2wpAw3IhlRq9gJtJKmyExILvT4wX1mjiWOKn8mez0uzmw6Kjly/+SYPWPfN
	 iJ90r3O8r0O70ilUwcs+WP1CGizak7KU+X00gnZODwVjVz2rL88ZNStQmVP7aUu2O8Du7
	 v9A5+dYYoNqd1HdcjX1L08NtSiDRpZ3dWd7Og82g0HWEMr0bp9lrIA65hT9/qrv9I/5aU
	 gXZAWpqPQ9JnO/JQdwEUBOKXoQmBTAmcDKxZZwJiVZjNyqkjO7BUTre5+YpNCXYDLYT+a
	 sRoMb6P2vokoG4kcaTZIM5EuNQ0C4Ph2/vtyqoFnRn7izNuTjUaUdi+GTPkcw8CcLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="Ily/0Vum";
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7C606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 16:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Ily/0Vum
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id LUblx6DmoLvgbLjdlxvaFy; Tue, 27 Oct 2026 16:03:09 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjdlxwL5TuPyvLjdlxlTo5; Tue, 27 Oct 2026 16:03:09 +0000
X-Authority-Analysis: v=2.4 cv=Oc2YDgTY c=1 sm=1 tr=0 ts=6ae0cb3d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=5yiXoIB1VdVXcjoALQYA:9 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=P/10AHWvTXXg1IeFeEr3jCvHIaauZayPfb4XOkRgwq4=; b=Ily/0VumynSN
	QJTEba4EjGF3k+M+FYMQlIKp7+2l304TbyFsMhfMwZYlp4LcNAQg661/WVdqVcaKmsW+2ITynz4tJ
	Bf+tYMoGeaPNPqplssvaod1kqt4PAO38obzepgRDusvIlSus1IYxiKP4d+p3BxpH4COTONx1iA8Kv
	bRW81MBu4VrqCXZWNz9rOzCnZFAG/G9Ao71gBvyMXbl3p2p3gwUIYhJuH8xwlJvvkSnLVqX4/9XM3
	stw3tRZSLrrr5YeFYzUUpRjC3cxcSuBtW+fhYyjoyFD+HXRXg7yZj3GLWfxWx59Zzl8mIF9meHcPf
	1X/wym0baePV7Q3SOPwdcw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47918 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjdk-00000000cJY-3WmX;
	Tue, 27 Oct 2026 21:33:08 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/8] watchdog: core: Restore WDOG_HW_RUNNING if stopping watchdog fails
Date: Tue, 27 Oct 2026 09:02:59 -0700
Message-ID: <20261027160302.2519282-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261027160302.2519282-1-linux@roeck-us.net>
References: <20261027160302.2519282-1-linux@roeck-us.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLjdk-00000000cJY-3WmX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:47918
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJzAiNiFIzrezt9rFPvERncGoCuAEd1mJsNX71Mj1r6RmS16EHlWXPwrTb49j69uEGXZPwEoSPT2PekLbyvEktctMwsgeSDxcTaUInDA44GwD9MOlnX5
 o6umdNm89OhiNUGg+Eo5IudqQkeXHxNshC5UG9+cVEmFF4peI7DJBdtoePM0ulcXVAJ51CUeTjYyJrN8PNce1EQbycsa19V3mS4hlKkPyAayiN+VWQ65emGp

In watchdog_stop(), WDOG_HW_RUNNING is cleared before calling
wdd->ops->stop(). If wdd->ops->stop() returns an error, WDOG_ACTIVE
remains set, but WDOG_HW_RUNNING is left cleared. As a result,
subsequent calls to watchdog_ping() become no-ops, and
watchdog_release() sees watchdog_hw_running() as false and drops the
module and device references while the ping worker (guided by
WDOG_ACTIVE) continues to run.

Restore WDOG_HW_RUNNING if wdd->ops->stop() fails.

Fixes: 3c10bbde10fe ("watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function")
Assisted-by: LLM
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Moved setting WDOG_HW_RUNNING to error handling after stop() call

 drivers/watchdog/watchdog_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index af756ee228b2..47b0735ed6ac 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -312,6 +312,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
 		if (err < 0) {
+			set_bit(WDOG_HW_RUNNING, &wdd->status);
 			pr_err("watchdog%d: Failed to stop watchdog: %pe\n",
 			       wdd->id, ERR_PTR(err));
 		}
-- 
2.45.2

