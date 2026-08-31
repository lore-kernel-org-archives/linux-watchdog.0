Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02C46AF0A
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200215; cv=none; b=Y0w2ThUsDI+jufKX/RIp51tGL0mebcFOaW52l5WclFgIIKrTmkmoPxf03I+p3XlK8K2kc8l8+R9TIOPYH/LolFzKn9/HjHumSYsSnAFVr1ySxd/RG0y8qB3JKSjtoUNRxLdEHvhJ2PxvVNMZY7voS42j0l2uNK81xoRv0bwZSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200215; c=relaxed/simple;
	bh=xbw4b8lag8MyTeGZcrb5hN4Ez5F8B1eouB6Ym16ffLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUQ33zvdffgY8TatBGf6IYOdhvvm9Qk74OeGT6kRXdc/Ts2XM6LtavPnuy8CaCSFX+waCOY+iDEMLGtGGFw2BSRTAScmuIlfkEK9sOdpzQHHkJD/rTdJEqI+W5Y4qVKNl3YYwXYo01sxcU6PzaNr5+0vkFJNdInax4zCOv5ZlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vcd5GHpL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vcd5GHpL"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15e592da74so461482666b.1
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788200212; x=1788805012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QU1kfWJYR+xjkRuN6RGZEPHu4Juq/92TUoclvitOE8=;
        b=Vcd5GHpL+B6lKe/zgKK2BBkQJSvxzlIR/YaUuyROJxHfXS4TavndXRORpaetCAxmmX
         h2eEUxpKPVQKU9QRnZ418UvLPjaJHs20la9ABiwZs8uFR3aXQVm4V3jt/EkqMt5ej/Ct
         VivLhcA+gPf6an4dVPrIDCtosEM81nSy2Vljc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200212; x=1788805012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QU1kfWJYR+xjkRuN6RGZEPHu4Juq/92TUoclvitOE8=;
        b=iTqsTtWTWafBMZR2i9cQoCSBMGbtkLs97B9TGFx0NXFffPwL618sgBB7ErP+276ITs
         x4xVKojTUJqcOldslLvnpAJb3sc3bai7h52JwQd1DaHv31FJFJWrxLQsNIQLDglsWui4
         cviR2izJd04sSpPCDrQfx5/wNWN2dyUl+jxB+Oaxzi288VhVM/tJzdVL5JLayd83Ue6r
         sI+K6Say5EWwrx9JOdqsLfI6QkdsOjWabhrCZp2EsN1a0nzOd3VEcPan0G96ZhF8m7mK
         RSbDDXLBrieMdIx74X5LglXN0kMIM80lTruvr2Gw5kDcv61sF5AOUJGpP4/vxG2ggvKC
         uEpg==
X-Forwarded-Encrypted: i=1; AHgh+RpCzX0Yx8fyAxO6cde3Sa/uXaThzT0SDItVZTkqLaZgHj99XKUBGZY0Zjtz1AEBqJPrEEFdL2jN0ytO/iThDQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kvA8VmSX0q7o6WLSjRjlaHyByt+kyHGw6b60oClITikWv0Qb+b
	c3TWSDnIaHSAUYY5OeHpiqZzwxWWV9pMSb1F430fdcwhNP75t8AiHtWWj9hSltN0/sdbD1Xb9BO
	MmGbiLUyQ
X-Gm-Gg: AR+sD13bTR6CLHENZg5dtvXw3fqXHC3V5jti+ixZQSJUwbscT+5AfwelWcXp5e98pMn
	WTfYUGOtvhaVJRauxe6WRZOsz5bQdey/MDQ/FxLoMegXleE/YvkfSi2EyuCGB216M7M2vxMF++Q
	R8q75LCfEQ+qld48e6WAIHlzRfbfwLoPELu8jci/2TC6R5m3bB68X4X6W+r/+vVR5UkETnSJTqK
	MRleoNJVvcWBumLKbJLEgmplBYFlUaKVmyKeGZae0FSEN6VIL9ochi23QQos5nsiKirGTDKIuC3
	+rcME1ajSupJT1C+/ZucvvccTEJ6UOvihm0e0damWLIkJwXrAMkk1ubYF/MrJhcEz8Vk6Lr1cV+
	rI+4CNOIYn4+q2axbAz9FaJp4BAMWRPgWs69ihp8SaAdJdyF7fPS7CuWG75h9FMzL45VrkVMrUb
	LvWC7LJ+7TIVVpu+PIf6aL//LdISye+jwfUYtRf2C+hC4mH8VEBgRdcyxtAqFalkkZwb54Ab6D7
	n7QZhjxLm5qAZOTYcBz3QBAdIs=
X-Received: by 2002:a17:907:8b95:b0:c19:6104:e5e4 with SMTP id a640c23a62f3a-c25571fecb8mr1818699266b.20.1788200212363;
        Mon, 31 Aug 2026 11:16:52 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f273e8bsm469761766b.62.2026.08.31.11.16.51
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:16:51 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso26726585e9.0
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RptgznSURxFi1U5RMjBIgFFZP+1gLbCSv1Rv62b161vwIZ2d1wPOVwLpnCEjM1EfNBMNjcJC/+qIzE6KA4E5A==@vger.kernel.org
X-Received: by 2002:a05:600c:621a:b0:49c:dc12:2ab0 with SMTP id
 5b1f17b1804b1-49cdc122ac8mr48333075e9.11.1788200210130; Mon, 31 Aug 2026
 11:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com> <20260828-qcom-wdt-nmi-series-v2-1-363979fe6b6b@google.com>
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-1-363979fe6b6b@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 11:16:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaDEWktsK5vNWJY0txA+YJZcjha-VPhmKQX=XS5pF+mg@mail.gmail.com>
X-Gm-Features: AcwNN1VV28U2KlLG_KwlvZN_vPKUX9__aF5EBSUQ4pSV3pF_j6BfJodMLb9TnQI
Message-ID: <CAD=FV=VaDEWktsK5vNWJY0txA+YJZcjha-VPhmKQX=XS5pF+mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] genirq: Synchronize in-flight handlers during NMI teardown
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
> When freeing an interrupt requested via request_nmi(), __cleanup_nmi()
> currently tears down the NMI and frees the irqaction structure without
> waiting for in-flight instances of the handler on other CPUs to complete,
> which can lead to use-after-free conditions on module unload.
>
> Because NMIs cannot acquire desc->lock or set IRQD_IRQ_INPROGRESS without
> risking deadlocks, synchronizing in-flight NMIs on other CPUs during
> teardown (__synchronize_hardirq) relies on querying the hardware
> controller state via __irq_get_irqchip_state(IRQCHIP_STATE_ACTIVE).
>
> Enforce that any interrupt controller claiming NMI support via
> IRQCHIP_SUPPORTS_NMI must implement ->irq_get_irqchip_state(). In
> __cleanup_nmi(), shut down the line, call __synchronize_hardirq(desc, tru=
e)
> to wait for in-flight handlers, and only then tear down the NMI
> configuration and deactivate the interrupt domain before freeing the acti=
on
> structure.
>
> Also add a WARN(in_interrupt()) check in free_nmi() matching __free_irq()
> to prevent freeing NMIs from atomic contexts since synchronization and
> resource cleanup can sleep and spin.
>
> Assisted-by: Antigravity:gemini
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  kernel/irq/manage.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)

FWIW, Sashiko's feedback [1] again seems relevant, so probably a v3 is
worthwhile.

[1] https://lore.kernel.org/all/20260829011449.87AF11F000E9@smtp.kernel.org=
/
