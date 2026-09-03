Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196332ED24
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400484; cv=none; b=Ba//47zulKDB0mq02aiZThTFC/GriTcp3QVej2M3tSo9nrZkUEEg/4Y1IcwUYzTkFRPrPaqZTmoaSPDUhtK99VFNXvZ26islBkbUmmRrh5l+SXRBvCub3LK1eMrIjfiNiIFdh/sGOlmjUWxHkK6W/KPgp6t5hTZdi1mUSlA0NXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400484; c=relaxed/simple;
	bh=Ly4VtUan1zwedYrGni1f6+QpeHwXTU7FLbsfJvxWpyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hvqOua8ifMuwwi6K2Nxx1kYprIA519WrZAEWyqHC29QGaIrgzP8tilHDRs7oAoo5zkK3hGIGnPx4YARnnWuzASowyFnQUR+Cv4lpOZOH/AmDVy1gkA0P+WUZBPOKIWaLEoP81HzHx1kISISYtHXRZRxBvsmsoVsCewmskOyMwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdxUpjxF; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdxUpjxF"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso2509125a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2026 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788400481; x=1789005281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BFGT0XaOMkoxcnjGltb7X7sNf6EHxJSYeOr/S3w6LKs=;
        b=WdxUpjxFCdTU8gFnqWyZ5WBua5pmzj64gJ+bQGUKSQAc3UXUg8GfPVPiNwbi1ruHYx
         dcUCdtPkzuVdjef85qAxI3DbsazgTarguI3Rizr3qm8muZ83r1cEZqvsb4ATwxlIqe6x
         SIAHwTfZcBJS7dUxWe5Stg935wWnl0qqlP2KNlOfTVplDC58qG+47RORMRpTvy9pF5X+
         KtRuq43IhGhmuMdrAxKp36IBtL3JQwcGlSr8TmtyFPT6qccKEYhQwg1RWQooJB/4L6CZ
         vxpa7ErzpePnh9qqh9SwftT7j53flUaoC5YflBS4Jzn1+yeYjdsaU7TqcU+Fy3wr7GRS
         1x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400481; x=1789005281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFGT0XaOMkoxcnjGltb7X7sNf6EHxJSYeOr/S3w6LKs=;
        b=J0mb4MR8qLJ8ZaTFa49W+0vAXpAjng2zMywj1ugFIomrm10mmxgK2WMJgI6L2N5tku
         +WvntM4sJKgAXazM97BOBKFq3CqzyriKqS93aelHcSKHRksrj8zmj/KKnSfDdKVf8QJU
         moONFwfSq0TdkY58vwEe6pPjqBabESKkgMGwqyyxCcEuioxL8fcvmC6BzTD6Nfsk9NRF
         HBM7U4SmKgyDtfOEIkgQTFHZkAi7kCqGWy6fSy6wAAm3cD0EtR4qqyZaO67kb+MrMhw8
         FaErtk+DsVdYheJLCOqasn9+/HhP511Zf+vOcCQ5VsJbWVKSh8k/V7LeviMdBPAiCCTA
         iV5w==
X-Gm-Message-State: AFuF++mie18xhEOLHGF9nZGeo+CYDt1jabDZiI2ynhxHy4ou3lUBozgg
	o8gNnPBsSHTUqfELqhedgBEQwxEZnJoEsbe4dYXPzohw4kuWk5y7vERetoYoBC92YC3ycVbwDLt
	75zP5gv8Nbg==
X-Received: from dyblz13.prod.google.com ([2002:a05:7301:160d:b0:328:3b62:f49])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f84:b0:381:25ce:bcc2
 with SMTP id 98e67ed59e1d1-39aedf1922dmr13504108a91.6.1788400480957; Wed, 02
 Sep 2026 18:54:40 -0700 (PDT)
Date: Wed, 02 Sep 2026 18:54:21 -0700
In-Reply-To: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
X-Developer-Key: i=mrungta@google.com; a=ed25519; pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788400471; l=4831;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=Ly4VtUan1zwedYrGni1f6+QpeHwXTU7FLbsfJvxWpyo=; b=OvDGmW9xSU7HxU6eFp8ZazsLXZaPsWyXTu7Wf4JYdlbqH2b1wHTZg5oca8ar3QtfyCSy/x5D/
 twYfCE6gRo7CwEySCSzCM8Z0kNvIH/9bryqyAYUTocy1Y1gcoQtc1cc
X-Mailer: b4 0.14.3
Message-ID: <20260902-qcom-wdt-nmi-series-v3-4-f3999362a9ea@google.com>
Subject: [PATCH v3 4/5] watchdog: pretimeout: Protect governor access with RCU
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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
2.55.0.970.g62bdec98f9-goog

