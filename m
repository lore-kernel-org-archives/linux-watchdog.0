Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246452ED29
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689608; cv=none; b=l4TCq8MPqYfJAdH60UQYWEhlkLBhi66TpDfHEf+vhSrVbSHA4F/Z4b5QRVAbevCPrnvmXt2izKED+ZtKez4XpB3PQoKsEaTeNLnBcXnKDItYimZxCFvATITIGK4Ds+yaDtItUMpDZb8YZLPW8kq7Y516p14pHMrFzsM+GaDbPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689608; c=relaxed/simple;
	bh=Kp9CE48bTabbu7VpGK2iXLCSKus8lSoacT4zk2Yq+AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQvnRmRKIv26CRB6wIwMweLptOXOdqEyxfeNyMo7IXCfM/ykxLoOIHMEjcDok/vLtidnHLbxgaQclSAavOIRU8/RlI9p2NHM1ke4TWJKNdGAuPMvREqEeMO5J0iq6ovSyzldF0EGEcxRbReHTN+SnZLVaJGx7ck72wtgJbnQUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUnsJq87; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUnsJq87"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2d42b972bso2284835ad.3
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689605; x=1791294405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOOeJvOJP4u0GvXLFwAgs2A1imOHsTYXqHxFA32e08o=;
        b=kUnsJq873TiD9/sJhPbg0xr8cMbHIl3psrxalQ7og/Mi529uKCuH3BqfdVgm/qG3Jy
         9QkyzDRTbegPTh20ezcdIkbb4ZIp9rQaN5OeKIK8T2N6b7GKQUZOVQ5BOAf9HqJZEfr6
         PTIQNzHyOcwlOqmvCDom9Ze3tO3skqrd8yBmMCKTmVaW5w1JEEFeJ6+xisPDBOycUDzn
         CZBl9O4OJdvLkpYMVBwBcPl+G5XHluPBMW797rwz3GFA2sCURD9AYGmchLF/juVmZJ50
         LbwT9G6ss0c9hqEzG5RxVcmSwkT7Yyw5Z5G1AmrWLE3wLmtw7VhVCPN2ZypxxJkqBkmX
         6Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689605; x=1791294405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOOeJvOJP4u0GvXLFwAgs2A1imOHsTYXqHxFA32e08o=;
        b=pGoUDFx7X0UqtMirEQzKyQpgNwvkzIJXwBcPiio/FygmRelnJjK3dVrnbRcFwkxJKT
         WTjqWRjnOnADP+Imvhg/XGomDWCNVoJsqsEMGfqlp7vqYzSTrUaL0Yku2DHhfESoB15v
         STPA9BnkmozsmU0cZDrHyuKFkckUpHwB4e4K6nF9CApH6q89FIO2mwOuE4yGh4xUH0kV
         TdgN9rgNkdlbgfVx2AobtRpw+80mJU2bNMrVBQ+vI3KvLnSOa8Dk0BbVyErafGswfdq+
         4/7E/5q92S99gFZIwgTQHT3RsPQIEyN+sBAjgAgwOnbpJhS1DoA8b2L7+QkU0t8Yhxo4
         cSww==
X-Gm-Message-State: AFq9FYIwc9sXYUTJlE7z9ss5jKfth5WlwscaIbpvh5UeancNS44Ou5mi
	mD5/mVyn6ONs9rJbqUGSQRKicJ2w8pBfeUw0Rigk77uRtd+O+qrYZTN9ZKQfDmLO
X-Gm-Gg: AYBFou3QT2xALEt4H8uJZLCTeOwH2xsLFsDQv4wvrIKh0/TXPqPv/xxyKjqgxeRsE3B
	Hw1iAAjXCYj52mxaUulAb20BOm2xZKDFYEuKunWWjJzZ/ODHaOdYI1k4wQafH44YQRhVppscLNO
	aHn9ANJ5LRmnnnMXvmQz1dTkbHp63BoJDb4tdBFEE/ADljvQhzCQNmTerWUNI04C2qV3Zct7ebJ
	RZuHApaoksInq9YZVgELVV/YBdBZvOFFi1EGXmw1wPHiY79+n0+sqmBBkDa1SBeU4eRWTqRd5FW
	wLhkdKb5M0P6SOBtnd4aADlMUukf+dmwQzj8MuEKXC3wDvp+6C64R4rRiG+IgdG/1i9xHzQ5u82
	sKaBrZv/UEIINoTSOtzni81nx7alOm72t67T3oja/x1xEZKTM2T+XpBvv0Bctzwm/483RI5w+4G
	gd+caStKd1bFCMHGNEdK2EINv3SvrUqY9JTHXWRFzJzIIO86Hk7TcNDdI+KPQQklbBQE8qBcCVK
	Ln8Q3LQzblE
X-Received: by 2002:a17:902:d4c8:b0:2dd:c100:80ba with SMTP id d9443c01a7336-2df7e669010mr129912855ad.53.1790689605311;
        Tue, 29 Sep 2026 06:46:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2bde57400sm18234425ad.47.2026.09.29.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:46:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/8] watchdog: core: Restore WDOG_HW_RUNNING if stopping watchdog fails
Date: Tue, 29 Sep 2026 06:46:32 -0700
Message-ID: <20260929134635.2567137-6-linux@roeck-us.net>
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index af756ee228b2..edf2cccd1c0e 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -324,6 +324,8 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		clear_bit(WDOG_ACTIVE, &wdd->status);
 		watchdog_update_worker(wdd);
 		watchdog_hrtimer_pretimeout_stop(wdd);
+	} else {
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
 	}
 
 	return err;
-- 
2.45.2

