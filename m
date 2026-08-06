Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09C3DC4B3
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997713; cv=none; b=ikcBGZeKLGOpNBXk5XquuGVsFiThHLHQJTPONXUsbrVN9wxZ4TYZlyfDW0qDI5lYMsZCBziFpraSM3y79klIk+eL02gO5hotoDX1bErqou958hYXDn57VCn56CWnQqjc7WlTsdixdYsTCfrTkmrz3jaLk1fsyHEIa/sKaVjUAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997713; c=relaxed/simple;
	bh=L3hbq4B+BcCYiHxILELTPSW5NMXYS2SJNVs9fKF3Oh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAGoQP5MGyt5py5vQ1NZhHVCQhC6zEMpC1E+wqnlxBZktWAyntMc9yOyyHd4oMUzMJlccvgZF8skjqDuAnhYXtDHwd4wBV8E/HYbihj8K6uJpOQjdrnkdCWXDdGnu6yQMeZwv49dALWIPUZR+JsvmSDB4Ha8Nm2dmflbwcT7f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAEUbAJ+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAEUbAJ+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caf228a910so14917705ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 05 Aug 2026 23:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785997710; x=1786602510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UT7dco9WdetfFkkLKH2JjGqLsTlUyXxMnGEErvoVIh8=;
        b=ZAEUbAJ+wfKGtNYHTCjAOrlTaVVJIaWJ0Pmfn2Vz0n72VHGR/NAy6OpBrFUUwHntAA
         vGt0vkjYgveL+Z3Z9ayuwz7Xm1gLcbHMK8n+TdZtUx4jWyElEZZAkmazgZVwDaj5I1jD
         1ZXuA6WVzhls6oXI3I1BBY7cOOTWRvsW7wUND7fwBgeBwfa3gSkr79uzBol9p1KlYfU4
         /7RmczlacNbxjtApzVKIWp6ZZJOCJZJEmy/FfnMKFa5Gou+0sX6iI7XOpFROuclgk6Ht
         EsB3ONMhxVguwph/5yKh4M8fcIFyg3rYhAQ02epJ9BKETeFUqkq4YnOiAJKByK3lhCzH
         6Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997710; x=1786602510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UT7dco9WdetfFkkLKH2JjGqLsTlUyXxMnGEErvoVIh8=;
        b=pdjF/e0neRAJ6ifvL3T20JN4gtTrOEIrdInZoNcJDpVtgsg7qkt4QwPpZeJrThlAip
         5/tcd4kZPIzlZhM3R8+BqtYfrRm94Dy1KGBLD2RJXkPOpVhaGp/h0QWe8sSGPGFVVSsD
         pLCS0QxrJCfQijlAsAR0XBBgzhaQxu2JDEA1HPUqdOnq+Bx3LI9dTXVDsSwY2c5FnGWE
         2pfRQt/DYsBLm9Vb+V5tUH6apDiImwkMnuFoGIDAxG8fHzn0C0Bnq29nbLDx5kJzTr0+
         8CBIKI3go/tauGJGV7DEPQFtNN7ETZH9z0/j3Poq8wsopYEYhwRSs+d5oUzf/x0qa/Zu
         xljg==
X-Forwarded-Encrypted: i=1; AHgh+RovlfzWJQfP7Hir3IX8f76dlACfVExiTAkZnMf2vIyoOFg+yBxB/fOkyqZsJ/JlMqQkLfkYjzjKyyKyARG8ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf2D4kc6o1P0G4Kqoo2vUKgB/yRzfIeI4EVvJKgcsjGHwl9ZYe
	/ppTD6pla6QhWvZEqJyiBFvX854zu8uPuKagtrFj8w6X8hlI4NtgDpl3
X-Gm-Gg: AR+sD13/5s28pvlCBPolFtEPRgIu4M6JFH4swdv2zz+fX/kXJx+Wl2YI3CpH68V+cZc
	Sz4v+AYWw5StPXRE6Ai1Q2txAWfeeXKP1X/vbs19ADCsTJFNdJ+ZnuJgvkalYuXtfbhBeS7YksL
	v66GtsNX1GCUs9ZMspRgY6HDz46XgA9JBQMCkw0L6N0G9GQoMhKOCLXJ9c5Lha50Ehw/lmQqK5V
	voofcMBAvlQ++h49BBTQeYkloxa3zCmCMAClFV6XSnS/JBxm9amQ6F/V0AhR2Ki0ZQR5Ae8HoJ1
	hkhFn3Pghs9dWMvE9E5cXEXjWqeP7+ACjgRGm89J2OVLkAh6ZMz/5wT9M8aFjoIEdNpnHIdFj4c
	H5VTtpn1BNmLqv1zdeixENKXPOUfaop6Fa+C0wsicgCIihN++rOXuAw81IWmTYvkAEAUOBLYgxB
	mYZE8KPIUlxfLl9FicX/OMa7u55nbPqKRWAm17cjZ//7Z+4JI6FQChmPqLvQf/NBDXlax3S8/Bp
	uc+adDi7aQ8ysbyI0FzL6IIfklytLrP1I37wJnzkPlg4hcncOdGZsKRLeelUQGYisZsmrYhL/b4
	5Gqz
X-Received: by 2002:a17:902:c402:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d0ca7af9famr138798895ad.7.1785997710122;
        Wed, 05 Aug 2026 23:28:30 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4bda53sm25370095ad.63.2026.08.05.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:28:29 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] watchdog: stm32_iwdg: Propagate -EPROBE_DEFER from IRQ lookup
Date: Thu,  6 Aug 2026 13:28:12 +0700
Message-ID: <20260806062812.26523-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806062812.26523-1-phucduc.bui@gmail.com>
References: <20260806062812.26523-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() does not returns 0. It returns a positive
IRQ number on success or a negative error code on failure.

Return -EPROBE_DEFER from platform_get_irq_optional() so the driver is
re-probed when the interrupt resource becomes available instead of
continuing probe without an IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/stm32_iwdg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index b356a272ff9a..102f51084957 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -287,7 +287,9 @@ static int stm32_iwdg_irq_init(struct platform_device *pdev,
 		return 0;
 
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq <= 0)
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq < 0)
 		return 0;
 
 	if (of_property_read_bool(np, "wakeup-source")) {
-- 
2.43.0

