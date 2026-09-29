Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73652941F
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689602; cv=none; b=kuLe7RT397Cv0NGP9PZ9gmUKt98A0AEE8yVPxf9jYo9mqDPfU74BuqH0hOjlErJ2FIj1LX+5he3kWwX1SU71uUh5nfQRdPE6vEMsknDWN+Np7jmBNdcP6h3RuSow8nchaVsc4/Ka8lCaUX/LMQVTqWN9sleHmYvlETPRwHTTtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689602; c=relaxed/simple;
	bh=OAa9q3cLSXiQRNEW5TTriDBPc2WeM0+6aZ5sQ78+8oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2lK4GMc/YW/duS6IXTjtJH3y/XRm1DEvLvnJFYL567vRhio7ruazJVp+mFAXv6Rzm+oFfSlEVD4+JBG9r8DagbG/6hkqzS/AhoUZB8e2Mmd30uwn6cg/tFWEHS39O2jV+E/mrgvPZdJAVeO9ztLd1RKjXv+k1VwjS3LAUIr4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKEjwuSJ; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKEjwuSJ"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88098db8dcdso1735301b3a.3
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689600; x=1791294400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5jqeHUL/psHLhdPSpjDim9qXNo79pNu/OJu0wzPweus=;
        b=PKEjwuSJjaNQoTXEatXjqroND8IP2A48huJyh6SnK5AUU7eae8UlTMY79Wt5GdG83N
         1TdC5Htg+65N0BrMVSFdwpWgzhwapkT+Nf18F7AGDZ8wkStwRgoQP2FiZkDH+2rBgpjx
         ttlfXH0uqWNTEW+NbqlUWHV/iJYEKsi54yTdkiHUhf2vPcf2CT/9eJdsQKIFHWRcQPgb
         WVpBfRUlh8KfRQMiXHwjdybUaNM2Rw82dvTi9PL3ZrXo3CdYSYVO82EzN6IvEu+jpNGj
         DpM8rU/iztQ86jABM/vrf8YyN9NFLqDG+oppS/jhBLgVKZcAnHotDs4bunte/rJCjaze
         NFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689600; x=1791294400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jqeHUL/psHLhdPSpjDim9qXNo79pNu/OJu0wzPweus=;
        b=0pbgGKS92ubT5kqFxJMuMJELL0sya3UAL9rAlFx6aB9nbZaHxqW2y63VMeZqE/qLN4
         SaIOGNgd6Abv0/UlrQfZyQY26JuqbaS719hB9wcul5qPVl/u3Y1JDiOrGBb0xzdsOvlE
         +xuBbkJtluqAVeuYLYlT58sCxAIia8zoxH9Sgcs14KwIQgXoWVj9s49Pok0yeGZGvMBE
         igv699bY+vxjRufdFGJ/3fJ9FeOeU6O1MebAETGa1TCbwvTnZo5dUd9OugPuio6hivCA
         wtopS4/EsjJVHJ3oYjsWU3pASBYkS0OFXHcBWGbmup8JUwSJu8D+zsmoNn2CmOPqFRlD
         ljgw==
X-Gm-Message-State: AFuF++kzsp0jLsEyFE5JCPSUCSz2Hd/33ZDTq5AjCfRVQEYVeNDTRkig
	liqm/NoXU/6umEjbVlF8X+WkQPyn9ScwPAUq18/YhUS5/j/gN5OzL9dLhEZK5Ca4
X-Gm-Gg: AYBFou3o4I7X1cLbpP9CwfPfirmun7iPkizI0YRNJo3WGCC7naUQGZC7g03dPTDQ8vn
	ri2EcQQ6VQoKpXXorO9Wa2EB8DKaMr8ElfwsoDG/QYVPQIkEYBiyoR8fyYkP9vEcrbOb8TqYOnk
	QylQj6qKtkTb98e9TPov9NUWZtGYyUIBNAVOwvHGdEcgqvnwIU+vkYB9L1DuJukzxjQqoPDbJ5o
	QItdTBMAChfDj7XkGTZARm/sb0WZAg62eBVW7C4rzZR1hjv1Fj5fbQ+VOuxvgqJy3Q5W2y9lEFN
	ZY2hcJwpUeU7lp6Z6EqJ1hUv4cFwy25vrMwoHed9a40tQzmKAAjcHu3+SrQsqW5Etfclhug4GJq
	24hYEnHJN5PwKuofwx2jQ5nUSRNexNdJX40qPdqNQq4KIY5HrBjAKOqe0JZmAZYfLgrKsVJa8XH
	7VWPtx8zpeFJzqrkmMfi0gaNdCR22ijhN5F5gybJBER2C+PWWQo0Y7IJXXC7FycHcvqElI8emLq
	M98vV61c1B6
X-Received: by 2002:a05:6a00:90a7:b0:86c:f33d:e3d6 with SMTP id d2e1a72fcca58-87e9a614f86mr11516942b3a.9.1790689599866;
        Tue, 29 Sep 2026 06:46:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e28d7d23sm944357b3a.56.2026.09.29.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:46:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/8] watchdog: core: Clear wd_data pointer on errors
Date: Tue, 29 Sep 2026 06:46:28 -0700
Message-ID: <20260929134635.2567137-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260929134635.2567137-1-linux@roeck-us.net>
References: <20260929134635.2567137-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In watchdog_cdev_register(), if device registration fails after the core
watchdog_core_data structure is allocated and assigned to the persistent
watchdog_device structure, the function frees the data but leaves a
dangling pointer.

During device registration, watchdog_cdev_register() links the newly
allocated wd_data to wdd->wd_data. If a subsequent initialization step
fails, such as the watchdog_kworker validation, dev_set_name(),
misc_register(), or cdev_device_add(), the function cleans up by freeing
wd_data via kfree() or put_device(). However, it fails to clear the
wdd->wd_data pointer before returning. Furthermore, if cdev_device_add()
fails after misc_register() exposed /dev/watchdog to userspace, a
concurrent open may hold a reference to wd_data while the caller frees wdd,
leaving wd_data->wdd dangling.

Fix the problem by clearing wdd->wd_data on all error paths during
watchdog registration, and clearing wd_data->wdd under wd_data->lock if
cdev_device_add() fails.

Fixes: b4ffb1909843 ("watchdog: Separate and maintain variables based on variable lifetime")
Assisted-by: LLM
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e8c1fcb53c56..ed5b35184271 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1033,6 +1033,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 	wdd->wd_data = wd_data;
 
 	if (IS_ERR_OR_NULL(watchdog_kworker)) {
+		wdd->wd_data = NULL;
 		kfree(wd_data);
 		return -ENODEV;
 	}
@@ -1046,6 +1047,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 	dev_set_drvdata(&wd_data->dev, wdd);
 	err = dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
 	if (err) {
+		wdd->wd_data = NULL;
 		put_device(&wd_data->dev);
 		return err;
 	}
@@ -1066,6 +1068,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
 					wdd->info->identity);
 			old_wd_data = NULL;
+			wdd->wd_data = NULL;
 			put_device(&wd_data->dev);
 			return err;
 		}
@@ -1084,6 +1087,10 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
 			misc_deregister(&watchdog_miscdev);
 			old_wd_data = NULL;
 		}
+		mutex_lock(&wd_data->lock);
+		wd_data->wdd = NULL;
+		wdd->wd_data = NULL;
+		mutex_unlock(&wd_data->lock);
 		put_device(&wd_data->dev);
 		return err;
 	}
-- 
2.45.2

