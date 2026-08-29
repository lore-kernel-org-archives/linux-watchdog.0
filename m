Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB03976B8
	for <linux-watchdog@vger.kernel.org>; Sat, 29 Aug 2026 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965234; cv=none; b=nqa/bckidv4PVKtu9a9dUAmPNwL8dNXP/cI0ebvai9xfWoybPeoKproTOy20u3WLH7PZDR/DgxjQ5UahqB/9Yh3sOHsfV+2SlIp4wtu8KsFg1wJOprXVj8BpTd970vkKvt2CtevJpl0RQkt1pQPZLqYeiDE2W+ZZA4VrBc353Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965234; c=relaxed/simple;
	bh=VRMP7JkkrsgtGCqNZ8apRQnntFni3AQp0Jl77stRJ70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tDz7vtoqCyQ86blbiGi2ZQ2Zb6KBeGZq71nyP/N+U5D3wiFyBxKY6Zijjz0KuO86OeWOJSDkbSU2Omnq/2787lVUdmNpgCpDPaXp6m6c6oDiM6g0n4vSf/bmrHs6oWed/AyxgI2pkZK0N6CXQxSMBn4CRsaZGXlKDhaS0Cn5hoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WW9OtZjO; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WW9OtZjO"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so18698435ad.1
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 18:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787965228; x=1788570028; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xqu55i/xt2SdtDol/u9w0q9bCB+z+btqRC0BIY7IKUs=;
        b=WW9OtZjOqTJvoRWEO9MA1HjrFqSF1YUN7FvplJPkmyYJnNMz8gY0oJPdSbbBA1rAyN
         Vc5V3FXAiYVOoKZRSNXgGgS3fyvP+/GSyUM3Z3Rs0NZoh+9cZfdwu8WG7JhQnTK4MClV
         Hhzg2J3zEXspyetyrwtnQ3HFX85YvepWQZAm1pfb0aOTbgrMjdKAaPPT6jXl6X12mZWS
         m8kIFELngB1H83HqcVOYIftYU72z2WqaOqk00EZK9wVWYzu1dV1nK1jefUgDGnZpNsLj
         fAvav/0PH4qdAC+KhVpjN1wgYLIW38y7pynwbo42mku2pPMzlSRowc0ed1vzqb3Wl8BS
         58Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787965228; x=1788570028;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xqu55i/xt2SdtDol/u9w0q9bCB+z+btqRC0BIY7IKUs=;
        b=iDJn4XXbbdLvwxFF/3JggD1w+bkporhduhB3jdZLoM8qXdstBuLnyCf8sBrMYMj7nW
         /RTV0nTQdY92X8TIay6PLNYsIG/OKri2Lp3absuoMvUMR2mw2bno8nI76qDLaeMBGh1E
         6R+sI669bzW48Mcjs27WpglluNByopeCv20dAapw6w8CfjQdTHQplJgu0iwW7GoRH+XL
         2V4RoiAg1YO/3JO7MfXzpBwwEYd9Xe2MsW7kiwUes7ib2GJ/rHqjfUVo+L3QZtnM/hrE
         66Xnh3wySpbBnJjyFS6sbGsy7un2PynMQRaMCAfKumKjO2PR2MElhefm37ZIxlrbCQcN
         NbUg==
X-Gm-Message-State: AFuF++kMGOVVFsKumOyxI4NI4QyLbh6VOzKiiYmDs3wL4MAYj6/BLuqZ
	Ss4wu4qiBLAH1wUopW98UoY3+ZlPdd+ZrPxvhlpxPqk0xciOuNOA+mvKwZBRTkS+1q/oaPBngax
	nmtkyMElD3g==
X-Received: from dybqs1.prod.google.com ([2002:a05:7301:6501:b0:311:50ef:5b3a])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228a:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2d74ddc705cmr171196165ad.10.1787965228149; Fri, 28
 Aug 2026 18:00:28 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:59:58 -0700
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com>
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787965218; l=4776;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=VRMP7JkkrsgtGCqNZ8apRQnntFni3AQp0Jl77stRJ70=; b=CQZHeEJJRpzMeZ+Luy30tTlvb62nDg6Gs9sbPGqt+ftDk3VVsUC5Aylz4w4wA7a6YMiEL7Nja
 3ybUFt+GL+rCXWFMnkIgUGWRattx0hVGNakUrC6EVg1JO6A8CIPtMN6
X-Mailer: b4 0.14.3
Message-ID: <20260828-qcom-wdt-nmi-series-v2-4-363979fe6b6b@google.com>
Subject: [PATCH v2 4/5] watchdog: pretimeout: Protect governor access with RCU
 for NMI safety
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="utf-8"

When watchdog pretimeout interrupts are configured as NMIs (or
pseudo-NMIs), pretimeout handlers execute in NMI context. Accessing
the watchdog governor via spinlocks in watchdog_notify_pretimeout() is
unsafe in NMI context and can cause deadlocks if an NMI arrives while a
spinlock is held.

Protect governor assignment and dereference with RCU instead of
spinlocks, allowing lockless, NMI-safe governor notifications while
preserving safe runtime governor switching.

Assisted-by: Antigravity:gemini
Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 drivers/watchdog/watchdog_pretimeout.c | 45 +++++++++++++++++++---------------
 include/linux/watchdog.h               |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 02e09b9e396d..7fb586c77403 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -67,12 +68,14 @@ int watchdog_pretimeout_available_governors_get(char *buf)
 
 int watchdog_pretimeout_governor_get(struct watchdog_device *wdd, char *buf)
 {
+	const struct watchdog_governor *gov;
 	int count = 0;
 
-	spin_lock_irq(&pretimeout_lock);
-	if (wdd->gov)
-		count = sysfs_emit(buf, "%s\n", wdd->gov->name);
-	spin_unlock_irq(&pretimeout_lock);
+	rcu_read_lock();
+	gov = rcu_dereference(wdd->gov);
+	if (gov)
+		count = sysfs_emit(buf, "%s\n", gov->name);
+	rcu_read_unlock();
 
 	return count;
 }
@@ -91,7 +94,7 @@ int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
 	}
 
 	spin_lock_irq(&pretimeout_lock);
-	wdd->gov = priv->gov;
+	rcu_assign_pointer(wdd->gov, priv->gov);
 	spin_unlock_irq(&pretimeout_lock);
 
 	mutex_unlock(&governor_lock);
@@ -101,16 +104,13 @@ int watchdog_pretimeout_governor_set(struct watchdog_device *wdd,
 
 void watchdog_notify_pretimeout(struct watchdog_device *wdd)
 {
-	unsigned long flags;
+	const struct watchdog_governor *gov;
 
-	spin_lock_irqsave(&pretimeout_lock, flags);
-	if (!wdd->gov) {
-		spin_unlock_irqrestore(&pretimeout_lock, flags);
-		return;
-	}
-
-	wdd->gov->pretimeout(wdd);
-	spin_unlock_irqrestore(&pretimeout_lock, flags);
+	rcu_read_lock();
+	gov = rcu_dereference(wdd->gov);
+	if (gov)
+		gov->pretimeout(wdd);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(watchdog_notify_pretimeout);
 
@@ -140,8 +140,8 @@ int watchdog_register_governor(struct watchdog_governor *gov)
 		default_gov = gov;
 
 		list_for_each_entry(p, &pretimeout_list, entry)
-			if (!p->wdd->gov)
-				p->wdd->gov = default_gov;
+			if (!rcu_access_pointer(p->wdd->gov))
+				rcu_assign_pointer(p->wdd->gov, default_gov);
 		spin_unlock_irq(&pretimeout_lock);
 	}
 
@@ -170,11 +170,14 @@ void watchdog_unregister_governor(struct watchdog_governor *gov)
 	if (default_gov == gov)
 		default_gov = NULL;
 	list_for_each_entry(p, &pretimeout_list, entry)
-		if (p->wdd->gov == gov)
-			p->wdd->gov = default_gov;
+		if (rcu_dereference_protected(p->wdd->gov,
+					      lockdep_is_held(&pretimeout_lock)) == gov)
+			rcu_assign_pointer(p->wdd->gov, default_gov);
 	spin_unlock_irq(&pretimeout_lock);
 
 	mutex_unlock(&governor_lock);
+
+	synchronize_rcu();
 }
 EXPORT_SYMBOL(watchdog_unregister_governor);
 
@@ -192,7 +195,7 @@ int watchdog_register_pretimeout(struct watchdog_device *wdd)
 	spin_lock_irq(&pretimeout_lock);
 	list_add(&p->entry, &pretimeout_list);
 	p->wdd = wdd;
-	wdd->gov = default_gov;
+	rcu_assign_pointer(wdd->gov, default_gov);
 	spin_unlock_irq(&pretimeout_lock);
 
 	return 0;
@@ -206,7 +209,7 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
 		return;
 
 	spin_lock_irq(&pretimeout_lock);
-	wdd->gov = NULL;
+	rcu_assign_pointer(wdd->gov, NULL);
 
 	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
 		if (p->wdd == wdd) {
@@ -216,4 +219,6 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
 		}
 	}
 	spin_unlock_irq(&pretimeout_lock);
+
+	synchronize_rcu();
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 29cd03686154..5a3c35968cc8 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -105,7 +105,7 @@ struct watchdog_device {
 	const struct attribute_group **groups;
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
-	const struct watchdog_governor *gov;
+	const struct watchdog_governor __rcu *gov;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int pretimeout;

-- 
2.55.0.897.gb25b4bd76c-goog

