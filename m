Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3E46C839
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200259; cv=none; b=Go366OvgpxXzOmfB840aMycVVcHqx6KxVtjT56xHQTa/0aBMZSgbcUxIRHb0UtqG0Ft4nnkHJ8P4LT08fIXK1Wb+My4x3COeLPhKknS4awr1vO7DPH1DBP2Sk5q+GyaibHPAYclnIGi30LF7I3QWJmR9IBip1cS0JuqJbMN35p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200259; c=relaxed/simple;
	bh=PEP7TQkxkQfuISukWgXVA7v768GBhFcwG9ByxxIj2Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAtlD42ZNlYsisiONBJofah7J3ZFOgX3Dxu5spDBFJtbaeInlBvqgADqRQuhIh7Swi948lKo8iumwbl61FJ4s2Vs29DrdkSCOY/pwezLqnLy30toB49UzUpSgfwYlQXY11ryIyl+eLft3ZaBDOKXbEjmUrcInkbwyMsNcVHb+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oX5sWuA+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oX5sWuA+"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so6225302a12.2
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788200256; x=1788805056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yxans2cK+wuOhbWrIk6+cKJw70uQ8kduizE4DCZb2gc=;
        b=oX5sWuA+AY45lzPOtOEc8ceYgzJ4LB3Nb/EXrzlxc9/7hrcL1wUMq2Rypft+dVOhRF
         TlM+1w7avryapK6AqckbVK+wokfHv27PtZNatTrwh76c+fZ6NH5rcaQeCrSDZXLHxNxR
         ErIH41FYUTMFUSAwxfettVcBDFu5oCF4yAD3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200256; x=1788805056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yxans2cK+wuOhbWrIk6+cKJw70uQ8kduizE4DCZb2gc=;
        b=LE9nfBjG1HIOyG0PeMI1fWO3xDtbLwfNWRPl1zJUFWbxyiE2TPX9lGf92kh1DV54Ji
         LLn0uG9oaUy+nyE4TEDYhtvSB546iYKfI7jjo8z6EBt1c/JWuEbmw94M9LWPSmyZFYgF
         GpBpa+QoWZ3flPQEuyAuNaptw2Y7jIfVsuyQrD3PS6Q66w/rW5RcSM3QePGeYL1Rg9tS
         tlgwr7K3OsPNWxjUBoHIl3+VcvaRFbJbqG0s69XTgMv09aGvetLmUhMeHr/ZeOg6S665
         kjsz5zJmFABbP7LRPKnBLYxeeLJe0Av2ACxxxQuCe85EReVJFPNx5LmUYbVX2fuJlaQe
         ABLg==
X-Forwarded-Encrypted: i=1; AKwUvByY6p/31QOFZ5qwoDoZqeQ69XWNZUOKlumpTZaoaotFV8/1jH/EwDnchLvJ/XITk4aeANZevZQ8f+mGs+22lw==@vger.kernel.org
X-Gm-Message-State: AFuF++lAbJI7+F11hSuuwLzKValHW7hzrg9p19VxTB8gkDmh82yRDNJN
	5qJSbdXiQqRAJAQeCjWHNQvUn17KfLVfaQZHwXM3l2T7d1l97ozbsgHbyXKGuxt2AgYKG8J2zH9
	JzpcT67A0
X-Gm-Gg: AYBFou2E7tX2Rjm2xWxrn9Z2mmn+8aIYEHt2/tfWrpNcYhS3tIxPxxyzHEWoCWAI+Fw
	Usvv2d1VFB9JzdO52AncfE1IwYPlfe2wHfE1UPu1Ja/QZ5obc2eBacXg+QrMMXj3xcx/x66XPKJ
	F1FhnelySUaJNmXuwOo2Jxsgdm9HO3IPU1PKkNbDvMWyVJ7P45UsQlwBBmhOf9pbNEu6PDyhIRw
	lAwhssxQS6C9sMSCZQQh/OYrLnHbZ+5AbOfW2YDKxISrBjCwuJPFfr+XGxVfrKISJB9oGTXYt6W
	fkwS7BluXi+3CPSA3A9mdE8Dg4s7lyl/OhCVHEi64xzCuu91GvELwLDMeiMDoGW37BE5KEhJ5BI
	ipxG7Ue1DNvqb1hi/m1R2ZDaLHlEpwOLtlmHrwF7HTzj2IfyaIYH7l6LYWHzvM6VsOFVZV1o8ir
	NVSSbQZtWIXM2Wy3tgCUJm7pYZaDWlBuZIAWeAyIV7ennABqmOxzPa10aK6uf0vqdwFfZFVbk4Q
	ZwA/MFbLY9NtqWzHB2VtFJK37M=
X-Received: by 2002:a05:6402:434a:b0:6a6:32f5:ff40 with SMTP id 4fb4d7f45d1cf-6a632f60147mr9412633a12.20.1788200255696;
        Mon, 31 Aug 2026 11:17:35 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a611b675d1sm4069192a12.9.2026.08.31.11.17.33
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:17:34 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso26737515e9.0
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RodivQMF+Ls5zaaQSuXVwPIkbMHkTWdGd1KqXhiaHocLosTfrUP2cCwHygT5g3jR/hBn0+Qk3nIuRjfG27Z6Q==@vger.kernel.org
X-Received: by 2002:a05:600c:a03:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-49b91c20ba0mr403578475e9.5.1788200252252; Mon, 31 Aug 2026
 11:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com> <20260828-qcom-wdt-nmi-series-v2-5-363979fe6b6b@google.com>
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-5-363979fe6b6b@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 11:17:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UkprU5wLANHrRYmHLmX4UVg-1UW6VRzswv-imF2GeEpQ@mail.gmail.com>
X-Gm-Features: AcwNN1WgqYHz9yO5Zn6x_Khshnq2JOY9-1BnUBhOPILjjyGKtsa4_xEbIIkQ6bw
Message-ID: <CAD=FV=UkprU5wLANHrRYmHLmX4UVg-1UW6VRzswv-imF2GeEpQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] watchdog: qcom: Register pretimeout interrupt as NMI
To: Mayank Rungta <mrungta@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 28, 2026 at 6:00=E2=80=AFPM Mayank Rungta <mrungta@google.com> =
wrote:
>
> When a system is completely unresponsive due to an interrupt storm or
> deadlocked CPU cores with standard interrupts disabled, a standard
> watchdog pretimeout bark interrupt will fail to execute, preventing the
> pretimeout governor from capturing CPU backtraces before the hardware
> reset bite.
>
> Attempt to request the Qualcomm watchdog pretimeout bark interrupt as an
> NMI (or pseudo-NMI) using request_nmi(). If NMI registration is not
> supported on the platform (e.g. pseudo-NMIs are disabled), gracefully
> fall back to a standard interrupt via devm_request_irq().
>
> When NMI is used, register a devres cleanup action to free the NMI upon
> driver unbind, and use enable_nmi() and disable_nmi() during start and
> stop.
>
> Assisted-by: Antigravity:gemini
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  drivers/watchdog/qcom-wdt.c | 52 +++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 48 insertions(+), 4 deletions(-)

Sashiko had some feedback here [1]. I think the right resolution is to
not try to enable/disable the NMI when the watchdog is
enabled/disabled, just like we do for normal IRQs.

For NMIs:
* We're forced to start out in "disabled" state (NOAUTOEN).
* We're forced to disable before we free or we get a WARN_ON.

None of those are really problems, though. After we request the NMI,
there's no problem enabling it right away, is there? Then, if we do
that, we can make qcom_wdt_free_nmi() unconditionally call
disable_nmi() before calling free_nmi(). Now everything is nice and
symmetric and simpler.

[1] https://lore.kernel.org/all/20260829011545.3873A1F000E9@smtp.kernel.org=
/


-Doug
