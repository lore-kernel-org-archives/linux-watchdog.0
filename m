Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17385331ECF
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542110; cv=pass; b=rUCNiGksbTZdnav5c6EiJ7H20po8fPWXId95NCb/E9UelcFFMtpySc3zXtn1xmS7f4JeY7iCwRHt+PQcY7L2tUTlktJx30O0XM24LhDsmq3vzKwO/6asLyWw4GnSwMHiwa/9DQQtqmoKMZesAOAKW9ynIHsLc8bBD1V3STAPuCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542110; c=relaxed/simple;
	bh=C9VlLtKmH50xsWwtRRP5IuHzCSCmAklFtjY3laGwjFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIRSe0xSxTOQH5oFEfkBe9jZXM7iTtZ8sP/bSorHwNzzA5TEDrgov+Q3xpg9+j4WcztquAd8tcnRQelN7HKHt/DwOmy4IGqtysg4VBPxMu6x0RR9cqWO0I8WR/iRcWhzXPTCY4B53QP+i2dJF92Ai2v145SmlLe4Rc76hoAhh0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDhbcvN7; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDhbcvN7"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-45837e52d8aso638954fac.0
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 16:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785542108; cv=none;
        d=google.com; s=arc-20260327;
        b=khppfJgmB+OSRoHNTZmuFO/VKokw2YldBHs7l9k6JqE95o+FliSY9SzFWi8TaQz6RP
         DaFAyE8x/GpLrXM+vHfHu/wI6TyMWTfDlJ7qYz0dFlcRWMDWMFOGqg/77uDGSvRZCixd
         Moox92S7qo/KhHcDOXfCng1Cp9Sh+KHjvC9Mj2pPtk9wgudB4+WgbZ23W8zSip2BGslZ
         RXYz7W5nyJPd6+95OaMI2Q9aBNw/QPX42MzVUkKDOMfFvP/dZCLL3676igM7GwAnkwpB
         fbiRIDVJCSc1lS4lt6CIAC1T8pDsY1EQBYRzsv9xYv4pd+a87gTOyrA34KOx0oGwzEWN
         KFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HXfQAMpxkfrzDAULgv3rbxEWuE5UqJmUxJ1EP+tc8ro=;
        fh=jtkmzBJisZ3lZgV7G7GKP2pW+yGH8EdsrT0zfC2R5P8=;
        b=Qh5TAXmDp7XEi2W/DNXw2SSDRZ8piot30cKocwugUlvzA1bnzddh5Cdu9ewgLYmFAZ
         Kqhm3EnnGy9dRBulWH5LN/BHTTHam3jo50bXhsTzFj5JeAKa6E4wj20K4iQKCVorcryp
         yZfyRezkoZPhn7vcgasF7iat31DeGdkdWlfAcKLkZoPuHw0Z6yfJag0oi57BFGdbp23N
         fPT+34HIUx33OIaKXFA6dE8FB+mJ4mDTf9meNuIeogHv8nOTFqbScjd8Eg9XLYM+YJvL
         eWKtYoUM8YSfsIW4Cm4QRlJaC2s19imCaDURA/iShnKNUdKWVLFWpbHKSGxRi+s1SUan
         IiOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785542108; x=1786146908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HXfQAMpxkfrzDAULgv3rbxEWuE5UqJmUxJ1EP+tc8ro=;
        b=TDhbcvN7k8JUpjVxh8InGD1gMmKbxjRN0+SXqi86FjKcFIB2MG56e+geOujWk1f5Mt
         c6sEmfO6Jjse7L7XijEl/Ra0o9iKR5zd+JtCo5474iZxsBoxeeGVoiKzlAGoSdwdpWVa
         Uakr82lfrUPuzkzQbuz4ajT6Rt4q4KVeUdg63y5JplOFdE88aW7moGIZJEsHD/X4Bwj4
         pY6lziO1gMjXFUxRMECwfQoBUcLS5mmcTZlCY+S9x0whju+DmO/5ysogPNIlJaUxWCGw
         x/g4044u9dLGpQk9iUmOwsl4HRQvbIAJ6swzXMsOz5AYh7fs6AgVNHNfKfWPPChEF6qH
         znOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542108; x=1786146908;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HXfQAMpxkfrzDAULgv3rbxEWuE5UqJmUxJ1EP+tc8ro=;
        b=i3SZ+OuAOqhXH9Wq4P+PLMzs5TlqwQeF+2S0GFL4XuMRPmHF02aPhAD8e731LOeMX0
         TLgH6pDYNhUJxAhCg4XdfyiOukk0hDLv35RjAEJAhYPYhdsm/95Om8hnVi7C199ZNbwQ
         4kwuM+FbHPwYReYnCBVe7HVU4+opAXpu3CjvcFqqSP1uu5H9sS2gockC55u4cJCs3vt4
         /QW3oQ2PMyVLTbkzZ3glribdUbUtMWbIJ9McCzKY23nzQpYldjQoHu+rYYFV4Uv49NeK
         cY5cS82cIgzt0LashQ/9hhVQ1eGsaTJybI0QdfVeF+L840BF69XBlGyCXJ67V4R+dBFb
         MZEA==
X-Forwarded-Encrypted: i=1; AHgh+RpJR8r3hmL5R7TGOoDbWc7Sxu6N+RfNtawsEIMqtVqjOHx2CuQo/DGbr/hiUsx6vMZpcfuumTZ3+3/XyMgvRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YykNeWtFAp4nHTARWU4dDvWqjp5ZBZxDTrJ6RLALE044Ate16Eu
	JnWs1xROKwM2i076bv+XOkqCRiJ8jVMKEc+YRUm7CIYbxq5IBNr45vWihIKOk5km5xPxeSLCMD1
	ocq/ro7/oeJetnTMYjVk4xQFY/Zzv2gefYOeHDLKs
X-Gm-Gg: AR+sD12JCgdJQKAB2FVcwNCqPMg7+ImK/igPy7boGO3LhKP+vjSJiU41pYKCQ9uw03J
	LgxmYV/TdXQ1OQU7fwnxpmfvXZfsscaT/w+ZZXXaIQ0o/ARmgumCFO0wgoo2oIQ0hGzJxzQt5QK
	HRE3yWQWCkVXl2qMHvq8Hmq0bL6WYLwW9kF1ww0PGY12jl1MF6zVHbCv8u65AEN9GBfpbkFNXQq
	xuUR91YyYnMwLhfoEaztwOecoDEBl1k6bPY6fHQXBgKQGck+F50YIvTnFcjJ/e6xcjOhFno91fq
	kHJ4FiaPetmR+O0eaqYiRdCbetYbe6zjiBZ0Z59jGaJn7hM1K1CnfG+shVQIzY2ysueZuaSTLp5
	u
X-Received: by 2002:a05:6808:5296:b0:497:e0bc:afe2 with SMTP id
 5614622812f47-4af5dfec982mr3921572b6e.4.1785542107445; Fri, 31 Jul 2026
 16:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
 <36a7bd8e-7e00-4df0-abd4-e22b86e91ca4@oss.qualcomm.com> <f98f6f9c-9cfc-4fb6-8a1a-776b480bbad3@roeck-us.net>
In-Reply-To: <f98f6f9c-9cfc-4fb6-8a1a-776b480bbad3@roeck-us.net>
From: Mayank Rungta <mrungta@google.com>
Date: Fri, 31 Jul 2026 16:54:56 -0700
X-Gm-Features: AUfX_mzL_k9dmpX1ZOF80L0TrrvY4HKPp3atSt-zCeEnaDgw0LGyEmIOq5UxHsI
Message-ID: <CABz7rdDtevcOrS=3cmE8Ac7PYWaPmu=Y+NoJp07pc3ZQr3Pc+g@mail.gmail.com>
Subject: Re: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as NMI
To: Guenter Roeck <linux@roeck-us.net>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Thomas Gleixner <tglx@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>, Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 7:12=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 7/31/26 04:56, Konrad Dybcio wrote:
> > On 7/30/26 11:32 PM, Mayank Rungta via B4 Relay wrote:
> >> From: Mayank Rungta <mrungta@google.com>
> >>
> >> When a system is completely unresponsive due to an interrupt storm or
> >> deadlocked CPU cores with standard interrupts disabled, a standard wat=
chdog
> >> pretimeout bark interrupt will fail to execute, preventing the pretime=
out
> >> governor from capturing CPU backtraces before the hardware reset bite.
> >
> > [...]
> >
> >>   drivers/watchdog/qcom-wdt.c | 55 +++++++++++++++++++++++++++++++++++=
++++++----
> >>   1 file changed, 51 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> >> index 49bd04841f0c..19d8e91cff40 100644
> >> --- a/drivers/watchdog/qcom-wdt.c
> >> +++ b/drivers/watchdog/qcom-wdt.c
> >> @@ -51,6 +51,9 @@ struct qcom_wdt {
> >>      unsigned long           rate;
> >>      void __iomem            *base;
> >>      const u32               *layout;
> >> +    int                     irq;
> >> +    bool                    is_nmi;
> >> +    bool                    irq_enabled;
> >
> > Do we need to track this? I think we can rely on the framework
> > NOPing out multiple ops->start requests
> >
> Good point. Agreed.
>
> Guenter
>

Thanks for the review!

It seems you are correct. I initially added irq_enabled to guard
against duplicate starts during bootloader handoff when
qcom_wdt_is_running is true (since qcom_wdt_start() is then called
directly outside watchdog_dev). However, after inspecting
watchdog_dev.c, watchdog_start() routes bootloader handoff
(WDOG_HW_RUNNING) to .ping instead of calling ops->start() again.

I will remove `bool irq_enabled` from struct qcom_wdt in v2 since the
framework ensures enable_nmi() and disable_nmi_nosync() are always 1:1
balanced.

Thanks,
Mayank
