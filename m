Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB4376BE2;
	Fri, 29 May 2026 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089629; cv=none; b=CM0YbtX/Y06HVhV8Pav8IQvBTQUJoXpLx79Hb16Unp7S0t+sv/1jJTe53aZkgkTucgwDuPL/q/JDGAu9AAaJgudXXnZUUH7xlaFzwmXPyREpTJ4NCCouwAsxFEYMWcKfWBshlZQ88YZlchpWH67/TP5vz5tEOnptyq0obMoq/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089629; c=relaxed/simple;
	bh=Tx4rfkWcgmObg6q+pcOAf1CA3ek4CJeffzJ7yJbqttc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGEeoPCi3Ko1t8ewAUBGWVwEDRKycEy026X9xaQLoPwIlWhdaYd05vsyJuZck9KiSdtp6lmkp2iMOOl04ynRwEsVW/Mu5wJno4xW1x39SrG1030LbpamHhCPV5B3R8pC5dC9tCoktl/Vwb5VtqlU+uFotLKiCy2F0XenLAJ1Yg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cu0cGVpg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cu0cGVpg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e0ZbXbd/dw1VsVbUP0kZvfc279kxbpTeXOlDnyM1uAs=; b=Cu0cGVpgd3zgkvDl04AMBgR/UM
	HiQs/EZGpAxbnSR4rDU0tVoR93NnekQ5H97B8fcDeg0+tBbTtmw+n8tfv/JpLNGXcjUlb5nw4kF+n
	ZNnHGbqCFC6b/4tEjH7352Z1poVvwk8pAosXkIIu/E/3uiKewlXkZuWv2b+7FSNJG1YNa9ICPg8yd
	Yl5Zc/rhZs3V683nZsa66T2QSAuZK9Zx11QbRZjtW0yOZaQYRYSoiSDKeChW5NGiOOd8y4vM3UghF
	7pAvPddFUakdRtwBwhYK3I3oDqLXxhQzZmsWRqbBNHRx13pIVoL8My0+BAJOSrgx+PVtl+eYn4jlZ
	QWwbe2nQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4d1-00000008F6L-1uXd;
	Fri, 29 May 2026 21:20:27 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 3/5] watchdog: uapi: add comments for what bit masks apply to
Date: Fri, 29 May 2026 14:20:22 -0700
Message-ID: <20260529212024.2119204-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529212024.2119204-1-rdunlap@infradead.org>
References: <20260529212024.2119204-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments similar to those in include/linux/watchdog.h
so that the reader/user doesn't have to dig into the API documentation
files for this.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: s/Bit numbers/Bit masks/ per sashiko review

 include/uapi/linux/watchdog.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260527.orig/include/uapi/linux/watchdog.h
+++ linux-next-20260527/include/uapi/linux/watchdog.h
@@ -36,6 +36,7 @@ struct watchdog_info {
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
 
+/* Bit masks for watchdog_info.options, GETSTATUS and GETBOOTSTATUS ioctls */
 #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
 #define	WDIOF_FANFAULT		0x0002	/* Fan failed */
 #define	WDIOF_EXTERN1		0x0004	/* External relay 1 */
@@ -50,6 +51,7 @@ struct watchdog_info {
 					   other external alarm not a reboot */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
+/* Bit masks for WDIOC_SETOPTIONS ioctl */
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
