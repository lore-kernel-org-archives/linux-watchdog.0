Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EE3C1D44
	for <linux-watchdog@vger.kernel.org>; Sat,  8 Aug 2026 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786181084; cv=pass; b=Do/zBUIxS/axWH/evR+ZujBq6uYNKBXToL9Wh35QLqBObnbnXOmd3C1ivlVYf2TAn676yCaOjEL/YFpLcN7wBmOX42TZ3YI5yitaf1r0xq00XtPW1YqZE3l83Fmwa0PIQOYuNipScmpI64Zp5U4Vx+c6lXKcjU37bs5KxVtzTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786181084; c=relaxed/simple;
	bh=/vZ5XM4H6eO46uqhmy3Y4wauXN7Cl7jVntz/tJBe7IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ypvd8QqRVsMTh5QmN43Ykodg8wPDjod3UNzPWk13aZwBX5MXiGrksF/bxNL2Mcti2Wgyn/akx9DXiCheNUsM36lSbtZ7nkASAutwHusJGyt+sfnNAta05pIO/KullHZfdeH9z0/zlmaaUzLZJF9bFcNGe7MLPvgC/4zt5cmXfO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu4ZQeWT; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu4ZQeWT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso3108645ad.0
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Aug 2026 02:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786181083; cv=none;
        d=google.com; s=arc-20260327;
        b=UmW34pjicBxmFr0QbHvvfdwUvz5jvn+27gJoSmgLaqz6FOro1hm0G1PjoJ2ECAx584
         ml+MApSof55QR1yEDzfJpREvG9SlxgENQrL+nSpRrdJtSZNVktCxuwQQ74F/QnnJNd3t
         G/kZw4LZd/HIVS8FwgyFDlJ8Tae4NqjWUL+ehm7QrOnGOvJzkt+MJZTSdPDtDE4NzeGZ
         prjnm2rzrBP9pWf8EFu3vr8O6nvlk3MCQJtOP5+FYTfhZ8udNI5gC9dSq9dwlwi7eOy2
         5jMGA1He5xwjxsOulFoFvp+fpAmHwksBhQXmmW15wGVlfUI6blYV0VJrzowiex26iQ68
         T1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MrghsmMy56aL0iIdrpu+h7WNYslFByyIZgbjP7fVunE=;
        fh=zt2hjtFWVrBSbexOnXx/digRN2O0tNSOK4/ceCsrIlE=;
        b=apZzSddUQy7ZeUEiIT2cFG54KMXsfIe60jh5dGHl5LQqCPb9VmShkzhv4McjWJ51IR
         ahH6/ZFScCvYJepAodfQU4bot8033kIoXMq7EuM5/InkR58bJe9Sp3re/01WifBhZwO3
         5P3Uu4BpPn+v5Kp5uBpjVQ1Jti0Nk/jNK0Hmef9K7TzfYLUo3vsl05Tb84O0fBhXLvAq
         IICLmprWEnwWBLbedyI2yUOW48BtSaDhrF/E2tiseooajroeGMbAK3h+wB16Xq2my8ui
         XIkCRdtHrNAsZ/6OD+UWTgQrpqzxb7LqtQwc05pTMgOs2qV45zLIwH06hktC+f/O/KzY
         6cvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786181083; x=1786785883; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrghsmMy56aL0iIdrpu+h7WNYslFByyIZgbjP7fVunE=;
        b=fu4ZQeWTW/sTFwXA6oPSj/f8HC6GTVt2GUyp866LCrUa3rloM+gQLNqdZmlbC/3hWL
         XGwU4sUy2cm9qOwVGgbxyyRk/E47aGsbarr+15k+5XhsKCiVAhYfydMJiMMhRacq30wm
         e+fDtQAhMMdNff0D6wHmNXGZP8G1KiVMEdLBP1sBOskHgqhJM4NoBfk6TpZxWSYxaHwi
         VQkE48iH+eeb9ccplpCKWhJ9btIPBYOMQS00rVkLv6bBWcdIHouDPZtZe8Gt3qN6RuqS
         morcO8oIMam3SMuOott83VUJLi9ka+ADcwgzPe63vr9cvtU3yVZd9Iq6ZtcqvZe/XpRv
         +FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786181083; x=1786785883;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MrghsmMy56aL0iIdrpu+h7WNYslFByyIZgbjP7fVunE=;
        b=XKoEy4597Vq3K2KBSlxq6RUZRSA702vqQ6mSVm/R0s2K3qyPnZN/2f3Veh69BRkO0g
         cE5ix+tqnaw1kawDe5ZEjzcU+aSfDyFUDa2XKflVHp3w4EIs3Be2ZC1o1wxljCKdavvP
         ZIjMQzU0C89+ZVFBPuuVYblwL/NB3kj7uv6y8QNJOcNYpO2mJlfZSylEOHGIMnsuRRYA
         O18i34rZWWCuAZtfejeeqvPM2XYIrRTO25XlazrSreCrE9R3nEVhyyajqwNnDhRFzoWu
         mQqxD31z0Gz53yNRFQY+iEQBlQe76nJurgRMdN6FFH1X6yz9Nuddk7Nmdy8xsUskcRqc
         CXbA==
X-Gm-Message-State: AOJu0Ywk7F1M46K/9197kX9Jac5hpmIaLhv/K3r+p5McEAdBx3BCYUzD
	LjphUuHLFBS2FFB09XhII4CNJ36kcZL7GRP3wHqW8dNU7pRVfEaFeeyXzUtM5GsRttnbBI6qGH5
	MPk+Ul/JIzUMmb3CLPXJYnCa9dF86kLA=
X-Gm-Gg: AR+sD12NmNz09REodhY9tZmJNmWAVvqQ+YhGpM75ecbqQ8jYvZgK5rhnu0xjybUcpCX
	GrPfqYYltK/O9bj/17wfnRZcY6gq9X0TWxMmHMmdV4spRfBinWjnoeNkhQMFFozXHEDwPIqnTVq
	rQokTwgCiqbBQlEpAvTf8sFb2b8GlTuFxF4OSGNXvfskIugbdfL34a471WmLZUdfQGSpM/Xoacc
	tAM1Vce8PIglSsXPmXQNrCI/MIYN591YpNcWmUUgqiNpAEnIiewZDgYZOT0WgCHejJRkhNitvEa
	7xBTBtfEwFJJfzPMo1v3+GoFRRswhroH7qqEkqWec4FYlG6OGKYCPLKbDL9RrcCMs9A4cTbkGrp
	KrNnuPInDfqHT9V/OD9YDOk4VZQhtfdBt9OanniYO5POfoAAs5LBedSSycLV06Gp6ZvNRIyg5Km
	P5Y2m4g0WQLKZCTho=
X-Received: by 2002:a17:903:324f:b0:2cf:41ba:96c2 with SMTP id
 d9443c01a7336-2d2b2e2160bmr26820625ad.12.1786181082808; Sat, 08 Aug 2026
 02:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807080447.35479-1-phucduc.bui@gmail.com> <20260807080447.35479-2-phucduc.bui@gmail.com>
 <20260807081701.C3D691F00A3A@smtp.kernel.org>
In-Reply-To: <20260807081701.C3D691F00A3A@smtp.kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 8 Aug 2026 16:24:29 +0700
X-Gm-Features: AUfX_mzQ1raMOa_ddMDzuPQuG9imRPgE_uqf_ormA10itsLxjDp6UBVFtMIy1cE
Message-ID: <CAABR9nHHHEDz2hM3TeQRTMsRSUYHJBFgxH6X+26M1c0x=NJWFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: stm32_iwdg: Propagate errors from
 optional IRQ lookup
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> [Severity: High]
> This is a pre-existing issue, but since we are adjusting the error handling
> around IRQs here, is there a missing cleanup path for the wake IRQ?
>
> A bit further down in stm32_iwdg_irq_init(), the code calls the unmanaged
> dev_pm_set_wake_irq(dev, irq) function:
>
>         if (of_property_read_bool(np, "wakeup-source")) {
>                 ...
>                 ret = dev_pm_set_wake_irq(dev, irq);
>                 if (ret)
>                         return ret;
>         }
>
>         ret = devm_request_irq(dev, irq, stm32_iwdg_isr, ...);
>
> If devm_request_irq() fails immediately after, or if a subsequent setup step
> like stm32_iwdg_start() fails in stm32_iwdg_probe(), the wake IRQ remains
> attached because dev_pm_set_wake_irq() does not automatically clean up on
> failure or device unbind.
>
> Could this cause the memory for the wake IRQ to leak and leave a dangling
> pointer in dev->power.wakeirq? If a probe deferral or unbind occurs,
> would the next probe attempt fail permanently with -EEXIST when
> dev_pm_set_wake_irq() encounters the dangling pointer? Would using
> devm_pm_set_wake_irq() here instead ensure proper lifecycle management?
>

This could be the case. However, I don't have the hardware available to
test and verify this issue.
Since this is a pre-existing issue and is outside the scope of this patch,
I would prefer to address it separately if it is confirmed.
