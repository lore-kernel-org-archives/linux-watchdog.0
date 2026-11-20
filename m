Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178420;
	b=th35WYss3P8ayDyghOI7v8vBu6Q/rRMn+O80I4f4hhhI9eeJZarHVFTayyzQFhjPwAl5
	 xOVQxNWu824dvSiHlv06a0K21naJyifNhgzRLs7mztv56k8aBDBKpAEVauEkMgBpmnRWW
	 YreYSCWxGp91HnT6TM1iFI+M6ItypA5M9ERt4+DsuneJPlKJpBQa/GgWMRzCb0pJhp5x1
	 CfKbnvB3fXhhx0FAgs4cqnMBe3TOHfag5lfzuD9KO7vyTfLGy6x5CMXzU5e+oHcZqqBnG
	 pjsiKIQVjr3hsxHYZIEKsHMixJ5ecCZ8OoHpw2nWzdh3ba11qB4ZcAm/+oErFbasVZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UJMISfiR5pDroA40Be5qF+MZzcjNgVmAFw0u4QedqQM=;
	b=O7lofMtTkhUvXQ4sbnptnfWImZEqUVpNR99MD7esyX6EYJ5ZpCr3AN99MDeMoPwMpl2S
	 p5ReCFEhbnu7W7tjh/ml+v5OQHFe19dJUGkPi8RamWKIdb8qHQxHehMWi3GZxPhQDOo6O
	 noyYWR//E8XGxdiP7ypbXTF+9tbw9NKgQ9Csc2BJ3yVb3e/p/9lp4bITokgDKoNC+YmXt
	 CVkI3qCNpLf6pXdNlslRvd66HzK/SpD3m7sYP+JpG8+U71Sbzal1+g+TD//1BWm8tRGgJ
	 ut/HvczqGyA02TG86dWsWmid9HqQ21d8TSDOI5M95oyy9SbWqKaHe7q9iohpZcn0KPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EUcRWEm3;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99F606A330
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 12:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A99F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EUcRWEm3
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso518184a91.2
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795178420; x=1795783220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UJMISfiR5pDroA40Be5qF+MZzcjNgVmAFw0u4QedqQM=;
        b=EUcRWEm33jD5UuQRvJn/XK1JRBv+ACTe21XpkiujG/ybEaqpLWy1vXkNTLAZkaMyvT
         tKmocGQBJfPP4ovoVnkUAF7Uf85wpyA+VQK+Oijv5bcpfcqLU9Pqm5mKQvV99qfGfGg/
         aNv1zRfkzNLd49RzeOBt9FiZA5wBYi0WjTPFFmFygjCqV4cD/opBKiXoIGEuhvqgxrct
         +RNHWq5XN4mV8RzmeRFiLYWyOCw2RhXsfTdjaS/pgViC80UTU9VQzHkKG4zvs5MP1y2i
         rsjH0D6dXQUFerIe5k9OGwEkRrAgdBX24wxgh1EUwdhkx+MUcVOoI/0EN6SGMZJP9k5C
         CvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795178420; x=1795783220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UJMISfiR5pDroA40Be5qF+MZzcjNgVmAFw0u4QedqQM=;
        b=mGPOkmB9T3AUpST7dfvGeelBzTuLT+QwbH0TgaJI+uH8qbB6iV0Kxk9iR9b8H+d1gd
         vDOiGKM51L4YWS8EHMFoQw/P/C7SxN90o5n4egK7V4hUISaEMcXKAy5ddUjsv1i2kauq
         hW7aZpjcKXluPUyBbPO9lq2WD5y5bSFg3YNpp17XDqyCrXHoHJIeESqQjX98q/Fyhlcb
         Kz2SFPJ0ntQMIEk1ESGCegfWyRFMNlBqt6w1lfkXMmMEYsfhbP01rJDIIu2cDcjZSoKX
         AQ+PDkDOXaXB9v2SHtcsI14XJRr8/QUFZTvZkEG1VNK/DZUqSf8QD2hwxWtTVrf6qbGQ
         WeuQ==
X-Gm-Message-State: APuU4Z80H0XysY8ah1sRZUKKHUxkSiS+s1vAByRYuHnxtFytdVvs6oCq
	30NPqiIzeNndCgTDXQEn06ZbDOmtLor8nlrNmraGOLewH8riCJwwmO+pcSLISGCI
X-Gm-Gg: AZFdTZdiLV14IME5TPr1cGe3CQsr2D4zkSVORypCSX1mVSdApRC3VIp+z9RhaU1hRkB
	JwLyh2vm8Iu0CNmwA6B4rE8fdJrQunGb3AL33atClKyn+1vNeUha10T1pN3S/ziKiWhObFlWKk/
	HotCFMZJDJ1U9g/J8105fG86Sb47YQPnch7VB9tyy7Wq8XWjJgHOeu9XREZltfT96z2VVNkajLj
	K8h+moRAPT5fOjrtgr/NfO0O04KDTwVUEmHR5d8T3tN8wLcownitDDO/nU23EBufit2HLmi440d
	/JNjhjSVsf1Urxe9YtKsIfgcW8iNmQEz4Bm7ltgFK6GVFPlBO9bnR0xc4gce95Y5ajDD089CQPi
	vkOuUR6YL8WlS2mOMj8taKQGP4zgHum2yiaj3DXmqUAPjxE/HvF/GLlk/XQcDL3kP/03Xs6kNp2
	L7spEnG4b5XIanvMucP2afzkwANv2/V8BYuXVm5eq8yfuPWdnreanAjZyTLHfYed04rl+rhtZH3
	34U80/dg3hxpOW6L+/J9kaimCiHOeQHxX1C9DcsQwqqlmeTxL5L/OP1BCJga5A/596dQai0EGG9
	4UH6sWjm5xD25kOnhPd0Kw1zdFw9gbMZpaEdyW7Jy2s8f1VZ
X-Received: by 2002:a17:90b:388c:b0:3b3:c04e:4b74 with SMTP id 98e67ed59e1d1-3b41c9b2becmr2885362a91.15.1795178419721;
        Fri, 20 Nov 2026 04:40:19 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm7647317a91.2.2026.11.20.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:40:19 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] watchdog: omap: Do not read the counter while the watchdog is stopped
Date: Fri, 20 Nov 2026 19:40:09 +0700
Message-Id: <20261120124009.24264-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

omap_wdt only holds a runtime PM reference between omap_wdt_start() and
omap_wdt_stop(), so the module is idle and its clock gated whenever the
watchdog is not running. omap_wdt_get_timeleft() reads the WCRR register
unconditionally, but the watchdog core calls ->get_timeleft() from the
sysfs timeleft attribute without checking whether the watchdog is
active.

With CONFIG_WATCHDOG_SYSFS=y the attribute is world readable, so any
unprivileged user can trigger an external abort on a stopped watchdog.
On a BeagleBone Black (AM335x), with panic_on_oops set:

  $ id
  uid=1000(tester) gid=1000(tester) groups=1000(tester)
  $ cat /sys/class/watchdog/watchdog0/timeleft
  Unhandled fault: external abort on non-linefetch (0x1028) at 0xf9e35028
  Internal error: : 1028 [#1] SMP ARM
  CPU: 0 UID: 1000 PID: 239 Comm: cat Not tainted 7.4.0-rc2-00716-g23c62304dde2-dirty #10 VOLUNTARY
  Hardware name: Generic AM33XX (Flattened Device Tree)
  PC is at omap_wdt_get_timeleft+0x4/0x14
  LR is at watchdog_get_timeleft+0x24/0x130
  Call trace:
   omap_wdt_get_timeleft from watchdog_get_timeleft+0x24/0x130
   watchdog_get_timeleft from timeleft_show+0x3c/0x80
   timeleft_show from dev_attr_show+0x18/0x4c
   dev_attr_show from sysfs_kf_seq_show+0xa0/0x138
   sysfs_kf_seq_show from seq_read_iter+0x194/0x4c0
   seq_read_iter from copy_splice_read+0x168/0x2d8
   copy_splice_read from splice_direct_to_actor+0xb4/0x2b4
   splice_direct_to_actor from do_splice_direct_actor+0x84/0xcc
   do_splice_direct_actor from do_splice_direct+0x24/0x30
   do_splice_direct from do_sendfile+0x2fc/0x3a4
   do_sendfile from sys_sendfile64+0x10c/0x128
   sys_sendfile64 from ret_fast_syscall+0x0/0x54
  Kernel panic - not syncing: Fatal exception

Only read the counter while the watchdog is running, under wdev->lock
so the check cannot race with start() and stop(), and report 0 time
left otherwise.

Tested on a BeagleBone Black: with the watchdog stopped, timeleft now
reads 0 for an unprivileged user; with the watchdog started through
/dev/watchdog it counts down as before.

Fixes: 452fafed839e ("watchdog: omap_wdt: implement get_timeleft")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
 drivers/watchdog/omap_wdt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index c60bc678262c..82e50244176f 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -206,10 +206,14 @@ static unsigned int omap_wdt_get_timeleft(struct watchdog_device *wdog)
 {
 	struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
 	void __iomem *base = wdev->base;
-	u32 value;
+	unsigned int timeleft = 0;
 
-	value = readl_relaxed(base + OMAP_WATCHDOG_CRR);
-	return GET_WCCR_SECS(value);
+	mutex_lock(&wdev->lock);
+	if (wdev->omap_wdt_users)
+		timeleft = GET_WCCR_SECS(readl_relaxed(base + OMAP_WATCHDOG_CRR));
+	mutex_unlock(&wdev->lock);
+
+	return timeleft;
 }
 
 static const struct watchdog_info omap_wdt_info = {
-- 
2.25.1

