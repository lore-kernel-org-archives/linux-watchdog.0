Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D440F8F8
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223334; cv=pass; b=Gv4/z5ocJ9hqLQ9zpRc24kXQXqPqH0KUOho7ktin9yEx4CQP+PKIL863uJjzqtJs7B7HFYmbvRMzuweUAIOIjshQY62uBi6xzu3aHifg2ZX0RDATPy4fW5l7c5z0HxayaCIeGAaF1A4agb19W3Kr7DDut483CcINiAQviurFMUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223334; c=relaxed/simple;
	bh=Mz6eKL1dO/yVMh2gKnHIXdjclEc7dkcJ+5LpUg0VdfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uttXKphXGkMs2BtFpRvSmBNPLxV/Pv9nfijHC7+rxkQOQrg9PwsYKw+bQjBSZSqU0O4MT8wJHDay7ZsCJW9HpMFVrSiQqr/oGQp/TMyyLsrBMfb7gvZme8rTyBgvXkuE2z1knn9jIL2jcsl5TNhq6bJ5rqje3PnJXLZ0mHsjvXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAdzc55T; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAdzc55T"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1670dad7a8so350741066b.3
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 03:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787223332; cv=none;
        d=google.com; s=arc-20260327;
        b=V1h/RS7MVXYzt8lqGdfnOzFtZf35buWcyxnqSMi3TRulPxXSx3sn6tFr4hLJvoHhmM
         JZ6Tttnlm5+qLSqVGQA6cS3pWzyBVvu5+gOR/PpIv7zmK61Gyexd50VNF7dK/eA2GB9Q
         MHZAqg2CmvKb/+y7J8dcI0ATnlMW252KhfqwVsIeBoyLG3kwilvMMCn9bSGFLJ9kgVqE
         RbWp8MkKYY70tPbXVXT/o2czILSu6wRcNos5g3/HliMncqDFwDFhdzsvI2LL5Qxw4Uhl
         eehsm0lfb3qjzlb5I+PMf4bTsZe4nCHWC2zJiWPCNiZj1auJn5LvePwtla1+EqCQLAud
         znWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ipmbXrGZuUTW3clkvLRtCtAeLwQH+jlck342QgUqPnQ=;
        fh=O8jtdxd/ItTZT+RcFXxZ1x+MZgj4fKUbsEXX16Y4Lho=;
        b=B06wUCdQb7zeYQH+TvCpP9gHvCU2VwuMqnR3HmPwifd7/c5cxuWsEF8yJ5FW74C7Bp
         L12RCONGhWNKYVvdV/2P6O1NK3sbIFSW/HKefI55scw41bL/zu4RN7i+RtuM5FC4Rj5O
         3xeNHoXIXjsrXdgjxMFiUoz97OJUDwY8vJcQowGkPUJl1S7uvZFlzQ2DjOU3YtuqZm3J
         9aa+m0StmCXktThhL1EQ6ChF5Ol7pKnEmxFV+FVZVeMNGvi/S4f6uINifwe7OAqU8VcA
         koY3rAVbfxF2FanumoVAIm4SnshoXpVJs4WUJSQQALMVAHKQqlp/PFVucPer9dcRqdTO
         ir1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787223332; x=1787828132; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ipmbXrGZuUTW3clkvLRtCtAeLwQH+jlck342QgUqPnQ=;
        b=EAdzc55TT02QA4hkh4myhdz4iSOZQx9WpLaxCXwn3Y+HbZIXNXASvbL9zYsFSQEpot
         EEe+MIq/B4fQvOTQB+uiA3FK+nJo6fVRG6IgxstVjbwJvdnKwYpR4UMxpTlH97dyV6H2
         8EK6QIJCVVOQt7yHbvNAc8sJcp0CqAfHqLLpVRxa13mvMAFIzHRrfxdijKtg4yNM7S+F
         Bt1rPw/Ik/i1U/eXXFyZl25NTEgFPw7tXEQrH2EkX7sjtqEGQ7IZeCc9ToYOQjYIhPil
         zTwdaB/3JZFaMBt0+xIbxLNOvkLfQsRpqF0RlNKTjvbX+CXJnfFVeTks33dllXFkhtVw
         rGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787223332; x=1787828132;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ipmbXrGZuUTW3clkvLRtCtAeLwQH+jlck342QgUqPnQ=;
        b=D9ii+0JnVAZrtQDNOdEyd0BsDOaeEfJR0f869zcLPGdb16swV6jWG57lwiAuuEswu9
         jPNSBnBO8CXyIZPV8tsvBjaGlWoGsej9K6XbomgcrI2GVLaUe9zX5UGXdR5JZdlEIV3z
         AwisDUfrqvdRh0uyjNZQJjJZHIg9xqDSA2ePucMWAJdPLpImRneSt7Uw6u9hA0APUjJj
         ernlYSfWcoUXpczl1QX/+Y3a0eMRQQbR8ExtIoNrx9xh22cuznlda5BsPJ/0G/XsJifn
         r2uO2RP8Hgrj2JAh86h3rjTCBiDTPPVcDZOSYx7gGEji9iJu/Prk5dWVq7nFHtQtypBT
         wpzw==
X-Forwarded-Encrypted: i=1; AHgh+RqXBru7j3juJhHFCvaibOTkgEzalSolu7d9LXhhR/czHvGWF4Oy8U6t7ZgSUF8nmOkHOR7Wp6loXDk2Htkj+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hQCup10twzHiQgEYw4Je876s+MuTZWEfaxoaaoc+22G3+EIF
	2c6+5wQNkIS0Qq5d9wQtYH7fpZIyjo6QbT0hpd94tcMCNSjZMc+jQOTIZiV5WB3I9qNGlOQBF3K
	wGKIgf9gZn658NtkI+8mG4kKFf0aqdNw=
X-Gm-Gg: AR+sD11ebAQISbgxWRYAGH/Dec0FnzSa+e16vZ345XzAmQnSEdg02NDlNCbr9VbgdC4
	q1z0/+Zv1tnHIITQPQgR9ljGYhGCmtNgXjrt44uLuBdjKnI34NYzRQAI3yQ2ZAVP9dGYv/KDI1f
	ETXgbUurkgqhkPvioUtENzwPGrteCL3patk9lbefjDlD5WuP1NR5S8Ju4Zvv/6FthFrMOtd3hf4
	fHaOpfkNy0fWLFw5RoHDNq4mrOGSfoHyPmaXh507c4N7rKqMTlPva2eUX9seDNDikOUHQvPRgZp
	AeXBpDRDeVvlVJlrIchyBDTlUZCv9BxmvV0KbZ52HYw=
X-Received: by 2002:a17:907:1c99:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c23f93178a1mr798064166b.1.1787223331499; Thu, 20 Aug 2026
 03:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819101853.44681-1-l.scorcia@gmail.com> <xqnpukvhtezpqhwjnxbqeddiaqlro4m5yjukpplv5mjfxodlfp@ijaf2trst7p4>
In-Reply-To: <xqnpukvhtezpqhwjnxbqeddiaqlro4m5yjukpplv5mjfxodlfp@ijaf2trst7p4>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 20 Aug 2026 12:55:19 +0200
X-Gm-Features: AcwNN1UZv97CCo3bWTxILn7aTXSi7ZUKBM5jaDSq07HQRpTQTLXr653YW63gQJQ
Message-ID: <CAORyz2Kp-LzLdUp=qWfF2xC4kCuUufj0seBKPcKEaebrXnhhYQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Properly describe mt6589 and mt8167 toprgu resets
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Akari,
thank you for the detailed report!

> This is somewhat outside the scope of this series, but adding TOPRGU
> reset support for MT6589 exposes a pre-existing problem with the
> mtk-wdt binding that I think should not go unnoticed.
>
> Until now, using `mediatek,mt6589-wdt` as a fallback compatible for
> other SoCs was mostly harmless, since the driver did not expose the
> TOPRGU reset controller.
> This series changes that by adding reset controller support for MT6589.

This is the exact reason that led me to touching the MT6589 code. I
have been working on improving upstream support for MT8167 and its
TOPRGU reset is required for audio support, but the current fallback
on MT6589 does not allow resets. If I changed MT8167 only, a reviewer
might have thought that the new MT8167 resets should have been applied
to MT6589 instead.
This series should cause no regressions as the addition of
#reset-cells itself only registers the reset controller for
mt6589-derived boards and it does not trigger any reset on its own.

I agree that fixing MT6589 should be an initial step and that upstream
would greatly benefit from the cleanup you described. From a
high-level standpoint it seems like all of MediaTek's WDTs include a
sw reset controller, it's just that the reset table is different for
each SoC. If I'm not mistaken, fixing it shouldn't have particular
repercussions on existing ABI since the existing fallback could be
deprecated and their compatibles relisted as independent devices, i.e.
basically what I'm doing with MT8167.

> ## MT8516
>
> According to the downstream kernel, its reset layout appears to be
> compatible with MT6589:
> [...]
> Note that a downstream kernel claiming compatibility does not necessarily
> mean that the SoCs are actually compatible. In my experience, MediaTek's
> downstream kernels contain substantial amounts of copied code between
> different SoCs, so I would not consider such compatibility claims
> sufficient evidence on their own.

Kudos for finding MT8516 sources, I have been looking for them for
ages! They actually reinforce what you say above.
MT8167 hardware is currently described upstream as MT8516 + display
blocks, but the MT8167 resets as described in the data sheet are quite
different from MT6589. That said, I've also noticed that sometimes
parts of MediaTek's data sheets are copied from other SoCs too, and
sometimes contain mistakes of their own... unless it's possible to
test on an actual device, some kind of guessing is probably
inevitable.

> I also noticed that the v3 link is missing from the cover letter:
> [3] https://lore.kernel.org/linux-arm-kernel/20260809160643.33991-1-l.scorcia@gmail.com/

Thank you for spotting this, I will list it in the next iteration!
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
