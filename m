Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891583B71B1
	for <linux-watchdog@vger.kernel.org>; Sat,  8 Aug 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179612; cv=pass; b=V+rVrfxe3UtUbAxJ+MCSv7Rg8aBEMhNpzr9ew9pw4x5Pt+4x0RLAhGYpaBzyBkQnqmgdvZesPHH0JndacoPRNRvm6nShFAkpy4hJw5xr+mArHyR3TmnPgkS5yuPl8/Gb7XRZzGbOXlDDlpFAezqmk1NT2GiCZT2dZ2qYK4IsUYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179612; c=relaxed/simple;
	bh=mCxucztXJVf444ctC1d185cDxrXRV3J8f3U/5bxqLj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfUFIYSu9Iw3/SZY9cAXAG9rcE0rtVmS2WJikZmnW73n8tct96d/tsJXSjRpYlDQZpmwRJEOvOBNugauktCof4icPAix6H43ieDVjmf34f7laVS2oedQkJTYSkT6+ITMQmCy5Q2tOnxTIb3pKGUnQOOdzY0s8DHwWiMEy1SYaK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DauuedQw; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DauuedQw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso276341b3a.1
        for <linux-watchdog@vger.kernel.org>; Sat, 08 Aug 2026 02:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786179610; cv=none;
        d=google.com; s=arc-20260327;
        b=CYsDXdE8xpRFLO96NLxdgmnjznVcfCXkFavo+vqRWXoageJdXIUbHaXPrcy8H/jdqb
         IARcYFkyZUwjrkXZUlFBoHIaMOhWuLxQOQx2hWSOTWlUNXA7IM0oH4sTr3pfIHbEwHDc
         PUgqyPUH8zxXzj2oT5Rm7KeATi0ltodntpjGiZzr3OELXqCF1YBICwbDYHpBjXWQtTPd
         TLZclYuCr2OEQM4w2ckPJLYktpJq3S6yx7Wy1Nw8fGK+egpNiwRYS5uqfiIp0qzMJdkR
         QiZAwIXnyzs9rM2UpiCzhINhhqLbKHLmrE7kLDllfxhhQzstm2G7rgbrwyvPm0pSxLv7
         P+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
        fh=Nypfoz7jsM8vaGQWYbd1c1e58H+qh7+4t2+4tmOIwhg=;
        b=j5F6JciMfQ4MAse7HN2c8f38bAManvvEcxtW1sAqQ33KcO1/NVnPpbW/aBZZyTjss2
         3sBvxa1hJb3CL3ikRNt8eXbls2XLCmMO4QblBIRXEQqJr1azQVCQKcT0h5knwDy3hA7M
         x6F1Y+HBuB8wx8iJ7gOV6OXxPLtdX4F9YBMjxqTswEoXJYyP+UaL725F9x4U5RgB3wjH
         TQd+7jYb02bsiUw15yFVhAULuHI6a+o8pc6JY9t6/bhKM98VnPQds4WbGyhITQAH59bV
         3ZGzkh9YKHRQlh+tuT1sspn3osZgHZpWrVcKPeaK9gkrmzUzl1eYDTgdDXw+4Fj8w461
         w/oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179610; x=1786784410; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
        b=DauuedQwmFshzIx5UXK3O9h0hq+ZgNABttSfoLR40ewZPKh6L0iweJWQL3O/1GTXL8
         iVDBYgKAUhMXUepVcNELqn697fAC4mBaFdK1Ozge9mful3GU52ZDJsiTkbiBmpXgcd/Q
         mo8lskOcISthLlBgZLAQOAXZkIVZNZ6VuXweHQs+782d0ihbrcO4AwCkFgpenKaau1iv
         BeXV25bvCsOEv3P+G9rAi1dmv8HVe/dW7DQg81eQQc2DuxDaP2Lx/8s+AkilGesF2a3B
         Ng7LL3FZWM7QaV0Rh2Dq5FtRV4lTxBsBKGoNm71kkDYNcR/xD9ERQI7CFU0+lz856mWS
         wKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179610; x=1786784410;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ttb+o5p7BZaAI5tLlxIO8Vba8Yks4awltsT919HRAqY=;
        b=PeZnIb4rYHyHCAD+hox6eIbRaIGXc2CQXhz1x+SsW+p1X+rNGGXsnJUJ/UmJdZ4fWm
         zfkuxFtyXVKUEe4AsEeU5C5YgTzjEHwik9iwhBkSdUpBut1awe3mgYiq/SXY5wpfL0x8
         RQeQmtAUdxMLQ91uDHz7Lpk+wO1ooTR3hmwiatk1o5ylHKGxaOHd8iitsy4/eNHY6cHM
         chaKP/o3V/BINAXMYJ/jrvZmO/45egVUdxUlzMvru4zeLI8e5SFt1eM/EU51c6Cy4ItO
         xp4D1WokhLmKOw2t5QW1pr51qlKZE/EqrF5QYlZzU/u6ItNMzvk2uY+ryvWYDdtwZA8O
         Iyig==
X-Forwarded-Encrypted: i=1; AHgh+RpXNyqElClvYiVH9tu6bIdI7omd5C3PuF2voO2bP0nZ0VMQ6oB2fO5Hnjkfqo6ySmbEag+Lr2j/NWs7ep1W4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/9X8udarhy6R+imHa3UUL5ltP7Es7PRcyqD5qxkTwWu8rgMc
	zyT3+UvcrGbN70sigT3k37AZaqHrfY1E2o5o6PJmig1iseaJ97w3GrHqiIvWwJuGr08qsqTayG3
	CDSYOJGfOowcH5G/PLOms+veDAHGD4aE=
X-Gm-Gg: AR+sD109nVd5oTIcxCrK0yu/EqkSm+HGNiIX6BInwbfAL+lW4faUlJPpqrnVE8dq0H1
	VOpe2Oc/C1xznwdi5qxuuf3pzzDfaH98HBHEZ4JhhN+C4tbcNgkJCTREUhjGb2jhJt4kRxnmPyy
	OAB+FOigHynWzvS1rMVbKo3H60M16y37HoVvqxtnxRbfRlS91k0SQ67qjNNAaDBqqkdGwNzYfTg
	coY7oV215EHUGjpB6YbPx8w48w5Do10paCLAkD6WOm375Q48ZnxqtgLBYNQD6ktYqQoutiuiGw6
	BNt/nBiVFXMx8bTtUVEEzqfqniMqGbYwlw2RGFkLNiqhz6vcLbnvwxsirF7roM4DprDsRjqY3lM
	l2UYFhJ5npT0O9MaE4s9RgTInPFd9FD7n/RN3xKHGPhhIdh4npbKT/1j2N73lyPVrNAjW4Vjjpg
	CzNMXlJIF6fmQ6g14=
X-Received: by 2002:a05:6a00:4c98:b0:847:e2e4:a36b with SMTP id
 d2e1a72fcca58-84f6b879bdcmr4679831b3a.19.1786179609674; Sat, 08 Aug 2026
 02:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
In-Reply-To: <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 8 Aug 2026 15:59:55 +0700
X-Gm-Features: AUfX_myHjaHhMRuATtXSNJb3hMWPktXUxThFKw4KnDmx30oADvzEsWx9LpvQM5w
Message-ID: <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thanks for the review.

>
> This is wrong. Check the if() path - the code ends up here if pretimeout == 0,
> even if irq > 0.
>

You're right. I misunderstood the condition in the if() path.
I'll rewrite it as follows:

 irq = platform_get_irq_optional(pdev, 0);
+if (irq < 0 && irq != -ENXIO)
+        return irq;
if (data->pretimeout && irq > 0) {
.....
 } else {
- if (irq == -EPROBE_DEFER)
-       return -EPROBE_DEFER;
  wdt->wdd.info = &qcom_wdt_info;
 }

Best regards,
Phuc
