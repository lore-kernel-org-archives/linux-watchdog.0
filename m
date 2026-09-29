Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51252E04A
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689612; cv=none; b=ntbo1J/eDQYpIhnUhJQVrA3CGWUsrzBK7i6oZ9whcEVQPaOzLg2JZnOBByfeix8CMkxNUNw+gBgaMsEy4553uN959USW8qnhu0bBolyPWit8vCuP8AFqCRCVcxLoDLwOmhc4ebyRG/kbrCGITOEal1fLM+Lx+bX5Q1vHudKNdBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689612; c=relaxed/simple;
	bh=t2v5EBAm60/SpL/4Kgrze9O6NYflbFJ7yUWXn8gk/gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRsvWZmErAx5LPh2CaHZBO47o1cJmgy3z7dUf6Vna7x8Ds9UP6xtD5O29EiW0+35IDb9NuucJm6Rj52sbWqcAWMjkR/tOCzF2ZoXDlg50o+Qsfz1SJNS1jZJfS5cKlMmtQY8hIGFiO6AURfyH8wrXh0ZfNKuqTqGXVoELXE9N1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhuFgRMJ; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhuFgRMJ"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so2441705a91.1
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689609; x=1791294409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWDGuqjnTvGg5NH3Y73uLzFZTfCnb2e6NEIBzCLI7Cg=;
        b=HhuFgRMJivirdLH3vJmAhlrL5Rrc8R4lmn+l5SEkKnC2KEGjnDSFB7S8u7g/1Iq0+F
         ouH3PZK4/h6qYle4gK+MT3ZYMgDaGU/3yp6MjuE6n8c7VJ5pDiY/INUwaCQBmu8Oo5cn
         sbLuHqvRLCtzXs84OQLzb48/NI+aqwTVttd7VWHATcHEJ5hu6wsOyZaRfZoWaNzRMT1r
         TMKtX0/9oL/YqW9vmWUJc2G8Bea84lXWXgdOUGhPitEj7lMAYso6WP1GOj0SL123Kz4p
         buVReSnCfOZjfhXKlmurJk5jJrqPC6jfBBWwcKvY+1H0GNctCzk3Wsl8PXPwPz0iC/0l
         tQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689609; x=1791294409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWDGuqjnTvGg5NH3Y73uLzFZTfCnb2e6NEIBzCLI7Cg=;
        b=a15AxpQ3Oh4+C7ClJy0oUmwYQGTryUKu57RhOR4cTXREkjgfG3JVpkCGq2FfGcVAm5
         EJNHG9435SCvYWCbfzvJfRPyX1onrpQWvsjSbgFgKjCNW68gg7OgBj1bEc9Om6Us15cO
         XJxTNflMPEEdtCk06ft3/YVPak97j0RMrvsUD7W/nLB2ht498h77LyVUf2M2Uu3vSa3I
         kzKsESQxWSixGj5hJ60HRZ6g+lASPMAQJ8sRnxKUjoDQ/jEnFNXWRfSycYPAeKOx7kOL
         abcghKpE3ECTid9pUJVlCU9eKJuX3tenINobZU7AiNTqr0RP3AqpVp23kIF4goxtOJby
         fGJQ==
X-Gm-Message-State: AFq9FYIFFDkUAM/1ABQ3rDHXW0VvKW1tKg2l0J77pc+YwgfTxRBCOOna
	ywwopSrA+t56dbz1i8AW9H+9B4S++AFGaJ4pu6JqHbasgmHYF33qAZLUARLOGIMA
X-Gm-Gg: AYBFou0MoEOmP0i3P4G7O7ejUqq4FIh5qzOYvjuiGa44pL2oG+eMcauxphxDLurCuSP
	jWrFprBYgsb994vslTeHCFv0ZfkEDFqZ1bGyuuJ1ukLj2I5x+qAEFtPRyfqaovQRpd7yHYxuiM8
	uxT1+VWMArTfJc6swlMAgPElZHOeWbt7QGhxgHVpdwpnyc2A7uDwMxA4Gf/6KfUpEG7GMde7jLV
	rnjllCjUetso1SnpUjXTpDNDMvy6LU4JfhhvW0zNAeK9kwBJ3kr97Xe4lN4cZpWzVYx9x4oIU1l
	2lW8xyNCHfSbYh6djJywoqDGKdD+jl+daNjI0YppFi6D+ITfHa/hMdZqB3yI4sTLy9qh2ZH4NMt
	eJLdqCGHjveAZhwNCopGOu8siVMWQ0oEO65imlAXmIKN95jPliGQF1CjkeoqDVEiI+Vrfq/xuH7
	y/xg+qmNG7RiDAWcPmi7NduvJkYH6kvuFHelQKog12Zles1MrQCoKS/2taxDWN+q/ISww0UmKdk
	5EmtmHyVKdk
X-Received: by 2002:a17:90a:51c5:b0:3a0:ab20:9e97 with SMTP id 98e67ed59e1d1-3a0ab20a15bmr8684739a91.15.1790689608914;
        Tue, 29 Sep 2026 06:46:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4b7890699sm276838a91.3.2026.09.29.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:46:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 8/8] watchdog: core: Update last_keepalive in watchdog_start()
Date: Tue, 29 Sep 2026 06:46:35 -0700
Message-ID: <20260929134635.2567137-9-linux@roeck-us.net>
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

When starting a watchdog whose hardware is already running,
watchdog_start() calls __watchdog_ping() before marking the watchdog
active, and fails to update wd_data->last_keepalive. As a result:

1. wd_data->last_keepalive remains 0, causing watchdog_get_timeleft() to
   calculate the elapsed time since the epoch and return 0 time left.
2. watchdog_update_worker() inside __watchdog_ping() evaluates
   watchdog_need_worker() and watchdog_next_keepalive() while WDOG_ACTIVE
   is still clear, using wd_data->open_deadline instead of
   wd_data->last_keepalive. If open_deadline has expired, the background
   keepalive timer is not armed; conversely, if the active watchdog does
   not need a worker, the boot keepalive timer is not canceled.

Set WDOG_ACTIVE and wd_data->last_keepalive to started_at before calling
__watchdog_ping(), and revert WDOG_ACTIVE and update the worker if
__watchdog_ping() fails.

Fixes: fbbe35dfcf94 ("watchdog: use __watchdog_ping in startup")
Assisted-by: LLM
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 24488c20539a..b9979f9957b8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -264,10 +264,14 @@ static int watchdog_start(struct watchdog_device *wdd)
 
 	started_at = ktime_get();
 	if (watchdog_hw_running(wdd) && wdd->ops->ping) {
+		set_bit(WDOG_ACTIVE, &wdd->status);
+		wd_data->last_keepalive = started_at;
 		err = __watchdog_ping(wdd);
 		if (err == 0) {
-			set_bit(WDOG_ACTIVE, &wdd->status);
 			watchdog_hrtimer_pretimeout_start(wdd);
+		} else {
+			clear_bit(WDOG_ACTIVE, &wdd->status);
+			watchdog_update_worker(wdd);
 		}
 	} else {
 		err = wdd->ops->start(wdd);
-- 
2.45.2

