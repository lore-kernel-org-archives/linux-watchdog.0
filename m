Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4037C906;
	Fri, 29 May 2026 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089629; cv=none; b=XA2gTtwlts0LrpNi+HvQG5GVUYj6rCR1ppwn6/3ca8S+b+zF6a1nXL2LTnuXUDDqW/m0vcg1PJsl2PDqLdlRrZlDN+xjQ99cW1aIkhsvuHkL1CHCEY5kI+K/bIhKs4SKxURwgA6nM+N4or+zBXMuDYJB+RyBF6s8mYdLId2uDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089629; c=relaxed/simple;
	bh=D056dRNoR9oA7TCTf5YDn2YTnuyKSIACzM6iLg9S7lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWs+v8Us+RI0xOBXl0n2NdrAfKwc8hAkIC46GnbrRVeAp7O3Sh0B62vb3TIK/fHee9Pb/ZIqEoPaDKQE0SyVbeeDqFznBwzjdp+UItIsRYxJI2waB+82S2PhXx2BFPwYbO+8tT8fyPUv+pOrAPFsGvJ7xplksMacPMbi6Eh3w9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GYS2mI+e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GYS2mI+e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N7Bca/B5hmAp/fuY2i7qJA/ehRCoNsUB9uBA43cnIqc=; b=GYS2mI+eJ38Ix8cOddsTIip8MO
	bXE/QYockid7nZNwzCgZmDGkPVrprafdgebLea64wNjt9I/pvpMq12zvoYu5yhB1TWSqd9Caku+Ri
	z10IK/Nq//mfOOwHAJ7PKFoWwYdhmH/Q2vMjGH6+v0tkMOU+M8n8CC1aIBY9yhZJLSgjt8SHyLOK2
	gwVjd2Hjy8JRcBsGG2Hi0qsfh4KQUxLszlCt5iwL+zo86YeuW2jvyDpHpDgG+CCQSvLKJHKl+rA+v
	bZUfWIR9sdXHUl2Cjb5lwlk+KcBolsuWsPjIMGbyLGkdGrX/++nyBkuC+n/Oy2MjgQSnV5sODPW6r
	/UFXoVYw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4d1-00000008F6L-3IGe;
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
Subject: [PATCH v2 4/5] watchdog: core: clean up some comments
Date: Fri, 29 May 2026 14:20:23 -0700
Message-ID: <20260529212024.2119204-5-rdunlap@infradead.org>
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

Fix some grammar typos and bulleted kernel-doc comment format.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: no changes

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org

 drivers/watchdog/watchdog_core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20260525.orig/drivers/watchdog/watchdog_core.c
+++ linux-next-20260525/drivers/watchdog/watchdog_core.c
@@ -55,9 +55,9 @@ MODULE_PARM_DESC(stop_on_reboot, "Stop w
  * for example when it's impossible to disable it. To do so,
  * raising the initcall level of the watchdog driver is a solution.
  * But in such case, the miscdev is maybe not ready (subsys_initcall), and
- * watchdog_core need miscdev to register the watchdog as a char device.
+ * watchdog_core needs miscdev to register the watchdog as a char device.
  *
- * The deferred registration infrastructure offer a way for the watchdog
+ * The deferred registration infrastructure offers a way for the watchdog
  * subsystem to register a watchdog properly, even before miscdev is ready.
  */
 
@@ -222,11 +222,11 @@ static int watchdog_pm_notifier(struct n
  * watchdog_set_restart_priority - Change priority of restart handler
  * @wdd: watchdog device
  * @priority: priority of the restart handler, should follow these guidelines:
- *   0:   use watchdog's restart function as last resort, has limited restart
- *        capabilies
- *   128: default restart handler, use if no other handler is expected to be
+ * * 0:   use watchdog's restart function as last resort, has limited restart
+ *        capabilities
+ * * 128: default restart handler, use if no other handler is expected to be
  *        available and/or if restart is sufficient to restart the entire system
- *   255: preempt all other handlers
+ * * 255: preempt all other handlers
  *
  * If a wdd->ops->restart function is provided when watchdog_register_device is
  * called, it will be registered as a restart handler with the priority given
