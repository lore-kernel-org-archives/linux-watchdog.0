Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39519CD0A;
	Thu, 28 May 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928090; cv=none; b=IUSyCnnEMxn6Yzg93Pk2PUTGIQEjk5n65u9T50WgBsiby2M3xxCG4pbf1uMdfiJpkfKwUJcw6xvC+QI/k1GhSk4nzpDaZH+s8flwUnAb3Umz4+06DGJVBonGwoXKgPXpWAP9ykX3MlHKrNyhifz1fOL/UcIujwfxswqwTWAEih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928090; c=relaxed/simple;
	bh=KKugxGyftPu51DYy5+LukcSckuJ5KkPf2yTprwVyTGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB+4HQ3XXmj/b1OR8pNyisopiJ7cvOzWYHNNDKV9FXXJrBxUZsvZrvulF43w/1coK3zkzBM84gYKhLBue7uZpwXD8pIpTB6MaWC8I8Y6LF/CdFSQl+LBnaGlqfqBxQK3pDNn1c/Hx3s4K294wcZPuoCX+0dKhd139J0t+Ciy7E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fFIBQLVa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fFIBQLVa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yWgUw/Fqw/FuRLerzJJk1tlIM0Vz1CFx2RpkBzTIonY=; b=fFIBQLVadUk7RVYTc4qiQ4fJ9R
	uM1lfDA7mUZ2Kvv0CWDyanhr1XHKsldlKeZ4fm4dC7ODPrDriE6/IlOhJoqBR2kb88IrSha69BYyM
	x6b5ZVhijfaxj91BIP3sd/JORsnzl2ZhlHFUiRovSlu8FSqOOG3TnuHFyyjW3dzgsNne3LAL5nfAv
	iefTw97t3KD3cdsoyFZwgYoByY7y8WG2NfKwTabFIT/I1O8bqxqPXtd9XShDtYPBIcJ1BdF7oh2TR
	gmVzwmnyw9ZRl5Ol8lfpMhNhfsE1if3QyYMnQoPkoHHiXak+WQOZNLK7ggwucu4M5MtUfu7vFM09u
	Kga6aqeg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSObW-00000004rZ7-21ic;
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
Subject: [PATCH 4/5] watchdog: core: clean up some comments
Date: Wed, 27 May 2026 17:28:02 -0700
Message-ID: <20260528002803.1260126-5-rdunlap@infradead.org>
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

Fix some grammar typos and bulleted kernel-doc comment format.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
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
