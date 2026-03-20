Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804543BB9EB
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014995; cv=none; b=WuiJrSmOhvFzYyRwVk1sYV6KmhoXxv1ZfXYlsi1rQWPuN9mUQCHju+++LxXY3PFwGJMGnMSgjysZKkSzH7TwPdEOGFyHETg+0ZmLPt+Vifky1gYupoZOxdvkQx9k5+QfDL5nlsP9/Xib9Ylm6GvCCSomJ0APmmxCpdYV7IyyZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014995; c=relaxed/simple;
	bh=+S1Vd+Wiky9zozGZMyOZgbhyNAkQ0Mjs18hVqVoehXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2DK4oeQPX7TuPA3Bd/AZRdEUznzAn+HIkiSb1huag9OG1Xpda+LQfpEtNhhNwoa7mpvOxUHxoo4Z4Rv1zWJMz2nLj5NJ9pgyi1YngM1cqZ/LuMtvX8qjHDNGtQYQWay4wLLjsFX+esRslnEFcbbxZ/tsFeLHyX2PhVQXTxYTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddhYt03Z; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddhYt03Z"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso12797671fa.1
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Mar 2026 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774014987; x=1774619787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfaiFd54zX0OS7ereEPa4IVfrUh095RBwWvtbLEAEXE=;
        b=ddhYt03Zbdexknbh+5KwXHOlOqB3YPveiG5WP+2odvus+UpvK8eIjG81R4AKf4uT1u
         Lcl8DoEPS8s9IX6pAEuQQj/8LM/tGX4A3YRhenEZnnsjctQ8pRKqJxPzcSBRa3OpSoSG
         IL7zKvndnEqpoNpWiACUIoAONDgtc2KyCfyt5/DwGaePD9S8JsiHtXOhte/onKIOPEGn
         skWgxhzvH/KrrKpZM+b34bypvwf21sefAi4hgwnJPg9sAqQed4TE5wvoq5Ufq6MnVjpN
         40wtVB7Q6FQd2UdrQbcXJKemd40tew4R1seFKz27GhJY3IQ4/mcviRqF2uY2trVa5DDq
         l3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774014987; x=1774619787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfaiFd54zX0OS7ereEPa4IVfrUh095RBwWvtbLEAEXE=;
        b=W1fDR8KbRD6bX6kLmxnaOtl+lN6ThM+gKX+57tv5bRk2wQ2WgcCJNF8SVS5i6KLjI9
         XDVwgGMiXurD54MzCvoPyWDNaJdXik0hHrlAUr2J7N4o62z5ZIQbGI+qfAk+9izRgvZf
         FKUadkwOLw+Ug6xS6VbuWkByNKu22BqZam9PkQ2BskXlSjiwjVW2tM17B9rlOeGFRl+C
         4laUislrgGVI3ajIppOkA1FXXLW/fJfeUw2IkuPt79PhO25kq0L8n32f2kiVwly2i2EU
         whZjJUtqzlAMEc5zglJMEZExVpJ7UOtGDQPF40zpsPLUFGsY9n8y71rlmYmqks2CycCl
         aHVA==
X-Forwarded-Encrypted: i=1; AJvYcCVXtq1tLAEAGR5VE9+WSs4LOco1gTngvk6KvoBHPHrzJ3wT6pkJM4/SHDBsZuESyINKe9F3JU2iuTVytqlz5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQ00/RufTxDZSgoTSJLMkq1EfOyTwBgSJJJLaNeQWN/llSu8W
	Tru7Na7iRDI8QCVb0+ganMozyT7GRSht+sQJcZWyE6+XB96s/MuYS0Ar
X-Gm-Gg: ATEYQzy0TTnnK73Zb6NNGPVpmvKSfCH4z6MdHcjrrXFqbsO2+pkTRd/HAdMgmHiL3Vj
	prj9txLEMmW/BxZ6iYGWENMN7xPe9tKCoo3gv6ppWx9Rj6mHYrVaDyrB7kQwN7048DvFfS1PPTH
	vyQ5/JGnIcsjEagN2FOwg92XIYHYwQFoHW3+11U6Vy5XyIgqw4fkUSBSn318X+KwxYCM8HdFP4Z
	CkRC9qAES2k8i6Tl7Ry6AOg5AwEIkPr+LE2nZ0mUa/CSZ5SkQd13psEDCk24sZ5MetcBaKech2y
	/3WhcHnOj19ULrzAMhOpkvwwYj8wigeOhsOhlfbOT0EgqpoN6falfo+xmpQDBEEeX8HIuu7xo6W
	bRkJlLRnpcHgo4hr3hwwxor3P1AvALl2U6jTrZ7xLiZrb6zCpx0By7CQ2jQTxmGxAV/UMbtXCb4
	DPAfn2fGAr03Yz5j8zwp7aXnRAJWqqoniWDxIGDYJpjcznIzxNBxNw
X-Received: by 2002:a05:651c:199e:b0:38b:dd7a:52aa with SMTP id 38308e7fff4ca-38bf96476e3mr12146471fa.7.1774014987047;
        Fri, 20 Mar 2026 06:56:27 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.148])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf97709d9sm5468761fa.18.2026.03.20.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 06:56:26 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	p.zabel@pengutronix.de,
	Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com,
	andi.shyti@kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] watchdog: dw_wdt: reset clean up and pm
Date: Fri, 20 Mar 2026 16:56:17 +0300
Message-ID: <20260320135624.223863-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello maintainers and reviewers,

Patch 1 moves reset_control_deassert() before any register access to
ensure the watchdog controller is properly taken out of reset before
configuration, fixing a potential hardware access issue.

Patch 2 adds proper error handling for reset_control_deassert() to
prevent probe from continuing when reset deassertion fails, improving
diagnostics and reliability.

Patch 3 replaces manual reset control management with the
devm_reset_control_get_optional_shared_deasserted() helper, eliminating
explicit reset_control_assert() calls in error paths and remove.

Patch 4 adds reset line management during system suspend and resume,
asserting the reset before clocks are disabled and deasserting after
clocks are re-enabled to maintain consistent hardware state.

Patch 5 is a final cleanup of the resume function error handling.

Thank you!
--
Best regards,
Artem Shimko

Artem Shimko (5):
  watchdog: dw_wdt: move reset control deassertion before register
    access
  watchdog: dw_wdt: add error handling for reset control deassertion
  watchdog: dw_wdt: Use
    devm_reset_control_get_optional_shared_deasserted
  watchdog: dw_wdt: manage reset line during system suspend/resume
  watchdog: dw_wdt: clean up error paths in resume function

 drivers/watchdog/dw_wdt.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.43.0

