Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45DC3FF1
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589431; cv=none; b=MPmFWG+pIe3kc+h3ew6HLTm/K47y1NjZienbky3RO82tNRLLLXma98RzPAA38dOk9GWmiDuAi20Wzp5GJlCT+lrjzwFev9/j2qpBLsMdi4DK9kP4BmQ5m97gcjvbao5ikCPBMCnGqTGFumpSaCEhecNt6Y+TfxrMlnk82xL4SiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589431; c=relaxed/simple;
	bh=6fNf3CPXkSOAxrDAM3xxb1yZNrZ3tbEp34H+jsXzCgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLslvhbeF5X8LEJBLPAGa9DmgM17hXBO8y7nkn1DXEb5Zv8hyAO3fAFpGgpZBsiJAJ8ZNYQLqQy2zY5sUIkoWTxxQy3CpEKz4l/d1TnJQMWG4M5HPhCzhHXJmO2AMFW3kpyc65ni5BR4Xadhe0vKwuzhJ/6HmHtLx9c/VipGVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGy8YHNC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGy8YHNC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so3493546b3a.0
        for <linux-watchdog@vger.kernel.org>; Sat, 23 May 2026 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779589430; x=1780194230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgEw8r5igQeVn4eqBV0mEm/CVgTgrgmSUh6Sdkb6gxk=;
        b=nGy8YHNCP+d/WNeU0gUH+jlT0Bpu+6CJoxac04llwj0IpCjJFHZxpfd56M09yrn50X
         5tjf3xyS12lHIm3fy2wNuoTNx31xOACD7wF4Ow9SBfcjJLWcvGnH1PY87AJDU2MeJWNs
         LdjvVI3ufgE9l8KdSjH8NNVg/B6DCwRqTrbDTvNu3dSBwGkk8x2ZAjDc/zMskYRph4Oy
         MRBq7o6V6BG/Vb/qXAvvroC1MPmjUP8igzXLdff6mVQrglJa/U1Mv+e9FLibu0FlL/eo
         oYbXfpfcL+Yf+DZ6l0vcacoUmQnra9U/r+4eLCbRsRrTbSccPoGmKvZjz/w7IeNJYFlZ
         CrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589430; x=1780194230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgEw8r5igQeVn4eqBV0mEm/CVgTgrgmSUh6Sdkb6gxk=;
        b=i77p5lwp4NpSSLPIRA9n3lEB4t5XYjmj1Rmfszmb92tsy4BCWkHkTb0e5QHjMibRlF
         do1oJoCGBNTJanaSwkWyAJOspIUNg1kxKgwkzw1ixvh0EpmVIOmD4Udu7kF02nswwy26
         uIZEnhOiN9XMj2iDsztgjwPKM1fuRiD3vFNCq7oMGjuUT0gHhlxl9a+q3ayQTJGK2EDY
         wa4qrEA50x/H3wehuVbIzN2ovcdbciOzUfa4BoS1mdTHYtmoluDkNZL2x94opCugs+O9
         z5/3RZAlZKC3RVFwnGvHvZoZMlAwCER+MuUhrhgDNJmzbRZ8ZWYJO8akdzrq4JEIi0ho
         AQ8g==
X-Gm-Message-State: AOJu0YwwnfX5NfznqKDnLNlmVdj2dSZ5qxa4kNyw+JrY9mZ5egEX9Ttq
	g/Zkce+/mY+qFznCjUGWLEMuwNSGR6UI7lQh+fthJvHjt7sCnDUx/wLxTVFBRQ==
X-Gm-Gg: Acq92OEm7/Ci7O4tFAhYRhpn+1uZPsKmSGTykwArfs88Uud9f0NTthUw8E5oD3mcb9/
	omlEWG89lKMeMrv1W1YRNK1U0ze44EITrtpnA93s8nSn63nHLqSJV+virDQKjke+SKM6tggZwSp
	/Gy7SHgJ9fRrd99AkMLLPRcnC5lzhJBs1ok1eQN2eB0w6KJGHg+IaqUPWm7woHh5WG36LZxlp5A
	SpwyOkt7ahvnu4jLmofdLg92Q23avI3rPM7F7QRBcQqiSzHUIhEOniNwvuIMO/28id321G50EV7
	8jo77ff8DYYDILHfm3D+yl0QZTKku6C+bNrD3nXi+iyb2BSjfNr/KTKmRE3uRw/9+D5csu00VdE
	Mxg0e778oFvk+EZqN1viO0kFUy58saXOySW+ZTUb0XVrZ4aFpLG2hAE+KTfAN3pgPCie8sPWm8L
	q0/ooPUsLa8VKy4cqt0AdZpTRVxjkLHbA34mtWjTFQvHl2oeRJgjQZ25tM6TYVbu2eWnk+hV2Zb
	GLpxGfO/vipFqaxiAMZB6ddeO9Uh0ET09I=
X-Received: by 2002:a05:6a00:cc3:b0:83e:d99b:f5d7 with SMTP id d2e1a72fcca58-8415f5a635amr9259211b3a.32.1779589429733;
        Sat, 23 May 2026 19:23:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fe97c0sm5277460b3a.53.2026.05.23.19.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:23:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linusw@kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] watchdog: core: assign parent with devm registration
Date: Sat, 23 May 2026 19:23:32 -0700
Message-ID: <20260524022332.179202-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user did not pass a parent in the struct watchdog_device
then use the device used for devres as parent.

This is quite intuitive and can help avoiding having to
assign parent explicitly in every driver using devres
to add the watchdog_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 Linus: hope you don't mind me flat out copying the description from
 https://lore.kernel.org/all/20260427-gpio-mmio-more-v3-1-fe1882351424@kernel.org/
 drivers/watchdog/watchdog_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 8300520688d0..726c85debabc 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -440,6 +440,13 @@ int devm_watchdog_register_device(struct device *dev,
 	if (!rcwdd)
 		return -ENOMEM;
 
+	/*
+	 * We are passing the devres device here so if the user did not pass
+	 * another parent, it's this one.
+	 */
+	if (!wdd->parent)
+		wdd->parent = dev;
+
 	ret = watchdog_register_device(wdd);
 	if (!ret) {
 		*rcwdd = wdd;
-- 
2.54.0

