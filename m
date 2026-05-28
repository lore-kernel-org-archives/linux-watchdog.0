Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24434389F;
	Thu, 28 May 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928089; cv=none; b=X3u0SOS2Bye4IATNsAbwu4xIB++tUtTIlq0eZbpZYp6Kv3ZwLU9PiKwpt0rMCuAi3Us+3AiFAKfZuAknC0ZPaSmN+7VrLMGorUz2jSp/pHPZjGzun7zi/BN52fIl/03kA5Uj3upCz7cbF14JImnR1YDXkqCA8pdYIfXEPzZ9yTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928089; c=relaxed/simple;
	bh=EdW20xVGsmA/NiUd4NEN5b53XesQ3mEfxdtpHwA71x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcmMlB/IrBK6w8BjBs1fLJF25eOTR5iB1Uba2sSAbwGAugfwDn0mI/+tVZBLmDsjIXjDUDcnlgVFhNjngQZlio6ds7tIMFe16TJOZzWadatIWbf1kHFnCORSkwwZZcuDD1NphaFkPS3xIc6jJVBb64J0dlzi9QXnupMhikvBUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I9Hhpwlj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9Hhpwlj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nOgR2lLiLc1VSZ5Ry2yGfoAtEh8GVCXHBx9G9lUrrQM=; b=I9HhpwljT3U5ojDlENsY7n+YMJ
	Yp1MCj2YOAQWlEvAVgrgc7gghfbsn706cPVp9w+VZoyrZfs3t2WewYTv+pyVxe1Qch73sOj9qtxiG
	GmtYo/quI0AD33kJub8LLKWN/hLAAnCGurGIJSLvxBM9ty9LD0GASWjC1dOOnmQ+9KJ9CkW0q04S7
	NgCqIyHZV5nu6cPk6tvHK7Oz/JHFKwgLdq3rb8BDV4vLu5MYq6k93NLXXfHbIE+Lwcy0s6SNv1Bzk
	xH/cVK0djJ7fVvUon0fd94WNIfGO1QNKAqPYdXzyOezGwRNJ8dZhJKIPxsBrBfw6SGtBMXmSnlxzo
	AP7kEgjQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSObW-00000004rZ7-0Voh;
	Thu, 28 May 2026 00:28:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH 3/5] watchdog: uapi: add comments for what bit masks apply to
Date: Wed, 27 May 2026 17:28:01 -0700
Message-ID: <20260528002803.1260126-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528002803.1260126-1-rdunlap@infradead.org>
References: <20260528002803.1260126-1-rdunlap@infradead.org>
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
 include/uapi/linux/watchdog.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20260525.orig/include/uapi/linux/watchdog.h
+++ linux-next-20260525/include/uapi/linux/watchdog.h
@@ -36,6 +36,7 @@ struct watchdog_info {
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
 
+/* Bit numbers for watchdog_info.options, GETSTATUS and GETBOOTSTATUS ioctls */
 #define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
 #define	WDIOF_FANFAULT		0x0002	/* Fan failed */
 #define	WDIOF_EXTERN1		0x0004	/* External relay 1 */
@@ -50,6 +51,7 @@ struct watchdog_info {
 					   other external alarm not a reboot */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
+/* Bit numbers for WDIOC_SETOPTIONS ioctl */
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
