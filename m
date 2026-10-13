Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1344B04A5
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872374; cv=none; b=QWiAlmqI5+2ikiF2UdwNPClVwrr/c0mn+ZXc6Cz6vEfIzdYNfZ00mDIKGnDQ7V3ZLeuhLVTm8/C8YnhEssWX44110KrEyQelgCciGVN1+PAMzHntdNsnapd3yoqO9AGkg0IXhVUXU9qxEG2Wfp02but4Qkkv0SwXtslx86AVKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872374; c=relaxed/simple;
	bh=qVZJr6BGUqZMkmvvywtMFv4Y+FRBCFB7MBPZsxpnpp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S3LBUALlVqmrB7X3mlUyRTODFhWzv9G8TN0BYXMfct8NFYu9rwoM+dYqUwFE7+6OXgdLFvBLF/xqzfTBPaxQO84TG2igBQI9VUsNTuNFlnE4HIFTxa9STL3Nn8APeXLwpwPxpGcfqxuz6aY2g9lXXZn+98rew0CQMNIv5JJTW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbFOB+kH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbFOB+kH"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a17baef589so20691915e9.0
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Oct 2026 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791872372; x=1792477172; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVZJr6BGUqZMkmvvywtMFv4Y+FRBCFB7MBPZsxpnpp8=;
        b=LbFOB+kHfGIvJmHW/7rO5K/rmUnwR2M0fAdOf3rpNk9XKwJQ8m/0tGz0SIKZCQh0Rb
         9OVUCCltNrgwGPfmKYa8beaOh3q5aOKoVMnagYIXLhleuYENI2uHmATmG1R3yN9EXxEd
         9wtxTyZ5CrXgG1PG0Fs+NOyvm829MLuhzqUd+liDSIHuWoiD3RYKLRtdGLou03QVa2LI
         PRB/wn9Uh4jtutFzV266YZ1NOu5LZMF87UKclgiNCaDJMKBnzKPGRwGMhw6oraijCcRu
         rXSdLrN06o9EZA6MClFoA1ZXwNY2zqw7zlKH+ighaPpDulr2Vk2ojhiHCQUTqUSMxpxM
         5plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791872372; x=1792477172;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVZJr6BGUqZMkmvvywtMFv4Y+FRBCFB7MBPZsxpnpp8=;
        b=clEdQtenLue7s4UvqueZJOpzvN9beFkwFhYa09t2EVob2yHk0Nlnuc8Lkxsdx91qUR
         FmmD9kC7JcRaKTXQzSbsy+Vq0MU0AuAuUKu3DZyenob5ArguK5elPQSkUGTbYFll2/kK
         LJmcyoLPJV5vdHHAatSAvkoabzB4HSyEcxmIF57FXvlLxgoUCBzOyGYTdKrsSz5xJXrS
         vrHdMMX4WiG9PBb+pfo7SXifzfDUz9sdEhvXhJ4T5NOvmMRfWQXVB1YHMCbFte+7YdMv
         5+z1gN1UK3lXqND/EeifYcLQuf4BXITC/yiOHN18FkOeS2LzKGNOSTm0BCNChcqoU1dW
         c0TA==
X-Forwarded-Encrypted: i=1; AKwUvBzFMOlvMBPkBuZfmze06yaoJTxfPGgHZ/hmhcOzHrYJXg6JrijekpdvFuRzbN1UNA+5O3XXPk0afoIgtH4WsA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIfWegFJbeQcsYNl1PnLQoAvGTM6Pnl+wL3j8qvGAmyoaF7nevZ
	tYzY3m9IZcBkJFWAA+/JBkqTFtQn/g94gfConmXHAU3Ywm0RpC3DWdGw
X-Gm-Gg: AYBFou0WAIDjEdFapF2Bwru6fU+7hznKJ2W2PFrpHmpyJ1PjF3pijp/p0Epy7aRk/yP
	pHFZbfnVia/ETBd0KlC3rO4UDxB2AZrfSUtG8ia7D1BZwTNJnRyoQkUoMEeN7M+TDWmyLxrub9t
	S1Zz4PwOtWJilZ4f0yDvmB8ti6b1vrOmXuI7+/Ni7wHITPRrcbhNoJYcDL4UWzYSIwEUkzcHNZ+
	/CAXfYB/Uv2B8ytmFKPeOcEbMQab8fr+iY+XEXGbbENXmmYL4yfoKVJYPcCTFptN+yj1agbUR4e
	MYwD3lDbcSKRiUd4+q62Kl9EAfKedg5pHfN/CxjJDZxqtNbwgZen5j/k9GGFfRRjUmk4qHv+9lC
	5AihjQiTomkE0EdJLqJ8hSPrKqHt1UVSKnt6Tsz0VawewHZya4Mn98Cy4oLjCBWoC7YRnJJ1qWV
	+fNgRIQ9gWL7cE5L2KxAm0MpfePxazZJjA5joYmw7e8ba5hYXJMVoqsFaMIOjZv4ulRguGUJKYP
	DXqy0M5KCDuUpbXYSfvCmfj9mmVA9/BuJ3LT4ZITSFs8xFnFKtzgHP3iw==
X-Received: by 2002:a05:600c:1549:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a18e491051mr250154825e9.17.1791872371668;
        Mon, 12 Oct 2026 23:19:31 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm264395905e9.3.2026.10.12.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:19:31 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Cortina Systems CS75xx: interrupt controller,
 GPIO, I2C and TWD watchdog
In-Reply-To: <ad388a91-404f-40cd-8153-3a0df3411c16@kernel.org>
References: <20261013-b4-cs75xx-s2-v3-0-181bb0d23f4c@gmail.com>
 <ad388a91-404f-40cd-8153-3a0df3411c16@kernel.org>
Date: Tue, 13 Oct 2026 09:19:25 +0300
Message-ID: <179187236532.3113955.136062642054162547@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On 13/10/2026 08:18, Krzysztof Kozlowski wrote:
> Slow down. One small patchset per 24h. If you send some big work, then
> once per 48h.
>
> Implement previous review.

Sorry, understood. Your comments on v2 arrived after v3 had gone out;
they are done in my tree (I2C and GPIO as modules in multi_v7_defconfig)
and will be in v4, which I will not send before 48 hours have passed,
and the platform series likewise.

Thanks,
Fil

