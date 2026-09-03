Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10609509F15
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Sep 2026 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469112; cv=pass; b=K7AMhTjL9hQ5OAlEIAgc+7lpx17lZbv9RQ0iDnnyVRGKkBIdc8IYcVk9l6V/y/4LXi92Cx2uNdAGL8zf7MKfDWFpp12P4Kd9ftD2Gjx6RqXzqtXV44dAnuL9EQ5V+HlbCAYwD5WbJr/ZPOG/t1mSr/PoitqPttEFzPJxl4TfLIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469112; c=relaxed/simple;
	bh=IzJt2StCxj6QlvTFqzNu7kT6yZRtUyvQ+pq8S6TGhxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ms7b6KY8HxwJCKEXQqHEzuvz2VRTIgLHUBjnS8UB/VbVgjrmluzyogr6OpqV8yO31ny0YASdw3xbJWETwlujjK1Tla4qDq/wayx/00gOJCBABMhjPjSXRkl07fZQfcrCsoTkaP9/8BVl1sFErMECzvWjjBx0tDaI7uU5QcepWrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEzjo7Q0; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEzjo7Q0"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so247372b6e.0
        for <linux-watchdog@vger.kernel.org>; Thu, 03 Sep 2026 13:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788469103; cv=none;
        d=google.com; s=arc-20260327;
        b=pNUZfVv4pANjhMDqseYBaICuadPIqD+Xhi86sUVYklTmmFh/RZnrGwc9TERhg/tcMT
         d8rru53e9L+8MLUttLApqp0zQWls0rX0OxzW2XvVCZoMrpn/R9vo2K5AHTmux1p+FWcf
         3dAFyTEHwMsWGazTiK9MBk0TtjCs7U4VHnhEDb+tREsE/mxWDBV5rjauVg97nAaiRnqn
         oj7XAJeL7Hx3V90p0d37H27xKDXwVqe5eAPBRac+st9pP4qNvMythg2TWj+bYbxYhHZ5
         6nf9wi2qK5/upmw6hKmzWQfb1T4UxCFA+Nd6dsYLRh1VPc2ETHiaGjG0MRACLeYqOlTz
         zImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kbk7DKrDKm1y0joI7y1zmZ6F6FvHdjLhRqiyG6EvJgI=;
        fh=RL2B6Yy9phBkucdE/yiuCs9QQCWUVXYcS00A3JhoYAA=;
        b=n5EfHs3bbyq7ZARy4x8vcbx65SrGedARMcyCJ9863OXX1X4uqDbcmpQMMoUBjsNw2i
         ZBON0eebhE5/edEMvbzK0FFi0dN0iPbNG9PcE364iYKTO4EL/ELKTHIjfSjAS/pVJ3vB
         KCcN22v9XqJtwfnPnRI32Iyi4dsEDLG/HFmbkm0fWBmNAh0iNejsM65Gyxxu7Ot4xX8s
         qZ9kdV+MBZbRzSXdyon6e2b1Sy7m/0pGWauaq0kcyb2qEI4K8Tt5a+GLmZm9scp48oSf
         38AvmG/fPL5HSeqPRIEAcScJ7WIlZwXcBLv9XxHiWpJ8zD/6ajOsQENL91hJ5SnRbfHg
         6tkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788469103; x=1789073903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kbk7DKrDKm1y0joI7y1zmZ6F6FvHdjLhRqiyG6EvJgI=;
        b=QEzjo7Q0AhP7JYdhrIHgLrTvkel/W7Q0FBtz6OzDPQmwAPESyHY30UdT1y2jgVAlie
         onwxoJk35kL66Vd0Y8kMDhomV3FzC9Tg2WinCImkIlznjnv6LicaqJulA1B1nlfdZDsM
         3W+bGK8DFZdx3LayCmhHGUA3G88l+rC6SYuG4sVRb57rE8jFR8H4IiOvLDbzliJs499Q
         eHp8LOqjaeQl3WLGpZI6waJQlkecu4mI33BtLTdXs1zLALXD1TGXGvlQhEIKRk2sdIAb
         aOA+7tkePxRuQEmeiex1iCaLwgmrhfq8zel2qtFpf7WCk5al1yEFyBpi8IKnkxkWqHlF
         EGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469103; x=1789073903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kbk7DKrDKm1y0joI7y1zmZ6F6FvHdjLhRqiyG6EvJgI=;
        b=JOpzAsxJHdLVqjwjFAgWX6Fp1XJYI8z8tc2f00tY2mW+y9vRA3pyHGuKQS0ZVVS/Iy
         8zkDha/ZS+RaJ/GzRgtcTwxwTqNHFtf0ygqFUL3UpFrf68xBanfQWh27qeCS5ClpV+rk
         IuqV8GycDAdiAVIKtZeLuDA0NRUx4YBaHWgoUe7XUJQQaFQ89CuOknbTS3nO9e/5T5OF
         KzT9yM/sMnhdT6C93iVX7Iu+zWpXxMbqO0ZiXMUsH+yvdb5XBwYmmq+9eVaO+vqcX4Uy
         8lShJWykSL0/h36gaOHtp4EP8A8UUKBtKwPDHs707jPREUDlkK1Wfk0/ITBE7dzq9Ovj
         VBVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzo3F8yip3m+O85RW4Ga3/Y92ZONHdCoiBeJXmjRkS6ftqV2q0mudk+5lzFKlO70p7aLMxrtZ/kWZnS511vNA==@vger.kernel.org
X-Gm-Message-State: AFuF++l+V3rA/dEswb+ha2sjjoAGwRDOjE34IZEN02CIcIWAaGTG+NBg
	fK18q2A5hoXHvLRgVwUvwsnX06OhgjsA2DtgAJ/Qp/+U8BXLgN8/uo3j0nKLCS3S6UI6aYPHRpN
	NdHjUTMC3yqiANXwEY95gFfp0GQaFTd8A8IFBX9fFqsA5U9oZxqT5mZcam2owjg==
X-Gm-Gg: AYBFou1MjlpjrWm1P5BzOy3GG1K/ys0kF3oADVBLz5z+sksIQ1qwcY4sqqVykvBYCDQ
	IjJNnZNLmPjraJ0Rt86/fY1j0iQHBkH9XAypSKph+pItvdiYL6/SvTJPuMPNwnaforXnw2MT5iB
	QGZjFw5MFHy59JRGwJBNULIg8gtlRKxSVjms6OutlxOpgsFibSt3ttp3spaAPVSupU6JzV0Is8V
	tHMotytpjkH9X0G9GP/6C2Vsv209gKb9ROCpqaQaHwN9vUX2E2mnxwlLsN7OWgPLuIgo0ke5+mm
	D66WYmXHbKeqgdxmMU6muErLLkR+A3RcZ02ICXrsCzU4yVTJbycupFELkKBiyzf1v4s9IVcN7Cc
	=
X-Received: by 2002:a05:6820:179b:b0:6b3:5475:4930 with SMTP id
 006d021491bc7-6b6fc9d05e0mr1462817eaf.21.1788469102528; Thu, 03 Sep 2026
 13:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-5-f3999362a9ea@google.com> <3de593de-6851-4a53-8309-a6bf13e9a8f7@oss.qualcomm.com>
In-Reply-To: <3de593de-6851-4a53-8309-a6bf13e9a8f7@oss.qualcomm.com>
From: Mayank Rungta <mrungta@google.com>
Date: Thu, 3 Sep 2026 13:58:10 -0700
X-Gm-Features: AcwNN1Wh4m9a6562DkcKps1tteFgxiKlf9013OvI175-psCFacunCQ9tfiMPwL4
Message-ID: <CABz7rdBv74pZe6jDRifTKRAKzGZB6L08n81_0gCqF0g=s+FEcw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] watchdog: qcom: Register pretimeout interrupt as NMI
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>, Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

> > When a system is completely unresponsive due to an interrupt storm or
> > deadlocked CPU cores with standard interrupts disabled, a standard
> > watchdog pretimeout bark interrupt will fail to execute, preventing the
> > pretimeout governor from capturing CPU backtraces before the hardware
> > reset bite.
>
> [...]
>
> > -                     ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> > -                                            "wdt_bark", &wdt->wdd);
> > -                     if (ret)
> > -                             return ret;
> > +                     wdt->irq = irq;
> > +                     irq_flags = IRQF_PERCPU | IRQF_NOBALANCING |
> > +                                 IRQF_NO_AUTOEN | IRQF_NO_THREAD;
> > +
> > +                     ret = request_nmi(irq, qcom_wdt_isr, irq_flags,
> > +                                       "wdt_bark", &wdt->wdd);
> > +                     if (ret) {
> > +                             /* Fallback to normal interrupt if NMI not supported */
> > +                             ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
> > +                                                    "wdt_bark", &wdt->wdd);
>
> GPT noticed this IRQ is requested but never enabled (NO_AUTOEN)

For the NMI path: request_nmi() requires IRQF_NO_AUTOEN. To balance
this, enable_nmi(irq) is called immediately upon successful
registration in the probe function:

For the IRQ fallback: devm_request_irq() passes 0 (not irq_flags). In
__setup_irq(), when IRQF_NO_AUTOEN is absent, the core calls
irq_startup(), automatically enabling the interrupt line as it has
always done in mainline.

Both paths are therefore enabled upon probe.

Thanks,
Mayank
