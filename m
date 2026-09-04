Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00364A2638
	for <linux-watchdog@vger.kernel.org>; Fri,  4 Sep 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530870; cv=none; b=tuVbZiMObCeBpxrLa9IkV2AhKYpa+5hrOqVkGPOlpf9CHyq9bg6yz2oke6Thv/RBNJWcrnCenQUMuBhI5kP9NvXHI1o8BoGPv1StJY7IRFL96bLXHHs0+yGPz1zT0cNwII5YocIrbAGrmlaQ4iQ2zfPwgNIaeYTIkX9oD+4+GvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530870; c=relaxed/simple;
	bh=UR+ZEsUUsBBDR6H3J4SrQikXuAGz4zSkD4hPrqvWIrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9+g1uR+dZ1UquRyARcymhs6X2QbGWh4TuCqv2QFuXECtdHtNcINbzL2r9nTb8j/mbHU22XlWLXb1fNOisMmIB0gombWovzUTfY0eZyfEx3TryeRTfdDA7x/UKvVIjYveVYkzj/NY9odsPYQvrGy6PV5HHb5Sny1xuSH0kj5M/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hD9lAW2u; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hD9lAW2u"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b4af4be667so1034266e87.0
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788530867; x=1789135667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UR+ZEsUUsBBDR6H3J4SrQikXuAGz4zSkD4hPrqvWIrE=;
        b=hD9lAW2uliS8ZYgkW/JRHsLR24qEYgVwN4mFoV6dLkfcaJsvr58yS61Z3PcJ1epoTX
         nB4a5wShjpUTWQR5by0oD1XL4VorpgJ5cNelH/44QcSXOhBviD7c8ssvqN/d7zjFJf5e
         v++CVtFDYSSBw2R7BLPpkyLEupK0X+YOdNCug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530867; x=1789135667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UR+ZEsUUsBBDR6H3J4SrQikXuAGz4zSkD4hPrqvWIrE=;
        b=hwKOa8VjKCUcq57gXxSquetEvpPAy9zxkMD9ClAHby86E3ozbrCSrH1/SwEDvqaehU
         yhqam2kVPg8WHxCl6Ju2NJL3mt8+HWlQf1tC4a4Xj0EZgeYzpOP+IxTYIunEZ0IjA3u8
         Jc7ITDwOZ8HNwBWbloZNXi6YyV8BO1mcTHZFJF1VyAUVispNKTKypkqVStQwhPCjSoEP
         IWMP5fqmTKKDXoTwC+i8TX+BITsTP0YeeB8sUWpJiALLRACYW1Kxa78R444h5HdDz+ar
         mGgpZr1WdCHiCSqZd3cUQVN6hCLDahzlIleHligDspZXk0wwISnhYs58q3EYRZC06zYp
         EqMA==
X-Forwarded-Encrypted: i=1; AKwUvBwuofaUh7q26nrV06i8G91eEZtHaJp/71pyh5aua1Q1eNDt1yfmyzOPtAwWyywA/CpuE5olsVbufl6E43ArOA==@vger.kernel.org
X-Gm-Message-State: AFuF++mnANkAntKL2p/ZirUVN7kRnCql8iX4WM3VsrhSyo/y/vsAEUtb
	1OKGoeTk2xtSCelxzKYIq5ORgTcYg3CrbidCPUrNbxV3m23t+jTtTnI9hnIKEYK76Cfa3+Y6ova
	YPAY=
X-Gm-Gg: AYBFou2jUWIoYswttdXMD0LOldIK/j4SQxT9lsUQi35d0bpVZTWynKtuTUKhuk/6vfS
	yLnjaHXv5NKrBF0Q+iWwOmL5sds6WweXu2v1iKMf3LRkYAv1BjhngEviVhh9/g9tJRs5C87/ebN
	Sv1teVY9oe3SBXxBQpV7pEj3c/CedMUn5vY0GoDBW4teUW3FJnezUYDKYLzrumCJm195VGRq5nO
	siaZ1cRgEh4cu1oxHrUZbwnVwcAqU+tysYTEl9XJnKxb3dSIDrNdu38zWuEqhKXwSaV/xfJGs9W
	g8d+VcAA0s0cOguW23r5TjueDAkdA4lcL1FPykDXp52nUbIH+3BjCpxvNHUAqZUOoybjXRs5WP7
	sx2RKTGtZ5mpEonWFtwsiqDQ7mdmLxHKPqlfgoTHHAemtB0bAicszWg75eDZw3pcuxvfcno327p
	HFLppMtDywpDVzW7GiOnWWU/V/t10Pv/JJe/Q1AdHQ3LXLaDKZiS/HPSUI1WyhqGpwUwSRN6QW1
	iA8UVwVyHZUnjN4glwyY6Fde6U=
X-Received: by 2002:a05:6512:a352:b0:5b6:183c:5ca2 with SMTP id 2adb3069b0e04-5b6183c5e28mr611534e87.64.1788530866688;
        Fri, 04 Sep 2026 07:07:46 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b619820db9sm389007e87.54.2026.09.04.07.07.45
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:07:46 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48584dc164fso995006f8f.0
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Sep 2026 07:07:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByL/Htp3ZOSQJtsKpPk/fiDTzjJcdcRZ4uxndPjQrPmRr/Qjdp+fYe8+B5wO5GkaCy6pSTJoK9jJTYDmbsXqA==@vger.kernel.org
X-Received: by 2002:a05:6000:25e7:b0:485:8920:cada with SMTP id
 ffacd0b85a97d-4858920cb46mr5715992f8f.18.1788530863620; Fri, 04 Sep 2026
 07:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-qcom-wdt-nmi-series-v3-0-f3999362a9ea@google.com>
 <20260902-qcom-wdt-nmi-series-v3-3-f3999362a9ea@google.com> <87ecf98ivn.ffs@fw13>
In-Reply-To: <87ecf98ivn.ffs@fw13>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 4 Sep 2026 07:07:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VMExH-K68aDfNsFBnQRSaYSNwbHo7hLhpzhpWN+r+Fsw@mail.gmail.com>
X-Gm-Features: AcwNN1XtHwZHgy5raT8AjWbFs0kW9c54GiCuQWnPlGop-re52BRNMJq1xExF-CI
Message-ID: <CAD=FV=VMExH-K68aDfNsFBnQRSaYSNwbHo7hLhpzhpWN+r+Fsw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] genirq: Export NMI APIs
To: Thomas Gleixner <tglx@kernel.org>
Cc: Mayank Rungta <mrungta@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Radu Rendec <radu@rendec.net>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 4, 2026 at 2:29=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> On Wed, Sep 02 2026 at 18:54, Mayank Rungta wrote:
> > Currently, request_nmi(), free_nmi(), enable_nmi(), disable_nmi_nosync(=
),
> > and disable_nmi() are restricted to built-in kernel code because they a=
re
> > not exported.
> >
> > Export these symbols with EXPORT_SYMBOL_GPL so loadable kernel modules =
can
> > register and manage NMIs.
>
> I'm not really fond of that.

Is this to be taken a NAK on the whole idea, then?

The last patch in the series [1] wants to promote a HW watchdog bark
interrupt to NMI. This seems like a pretty useful thing to do and an
appropriate use of NMI, but the HW watchdog driver is a kernel module.
Do you have another suggestion for solving that?

[1] https://lore.kernel.org/all/20260902-qcom-wdt-nmi-series-v3-5-f3999362a=
9ea@google.com/


> Funny enough there is already a driver which claims it can be built as
> module which uses these interfaces. Oh well...
>
> > Assisted-by: Antigravity:gemini
>
> I'm impressed that AI is required to add four EXPORT_SYMBOL_GPL()
> instances.

Hmm, I guess it's hard to figure out the guidance here. I think Mayank
is only adding this tag to try match what's documented in
`coding-assistants.rst`. If you've got an AI helping you with a
series, it's pretty much touching all the patches. I guess you're
suggesting that, even if AI touched it, trivial patches should remove
the tag?
