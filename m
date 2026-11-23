Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476515;
	b=1N0PXcHZFqHPaR7vA0Sagu0xIhaJ+ke4b4difN7SArfIEktNsGSdP9jAcl86pcyOjUsd
	 fuym9YD9xe0kiyYxfs4RDRYpAnxE15X68s5GhAVTWl0993nno6lbuoI9cYodRp1NGWXvg
	 UeHNYwpLQTSYUF8l+UEfWe2PEXeHxksVcPhHPD2te21r743opNqflYb400reu/MXH+Rnl
	 Dv96GEbsfm2UzCSvZkeLuKdLOyQluFhslcgGHzXp0jjM5kkyb/1T39TODFem+XBIHSpFb
	 spi2LPyW7Aq4Lm6SMKn+MjLHH5MONbiT1yi7SY35batFKX8yIvkAKdYZqJ/YoEuOv6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9y8eBhUOHRLpdlPNcmQfoTOPtq1wEw9bOFKY5UXmjUM=;
	b=VNERN7uAjflr4bdGulosDk9k53WNRPU9mF0lyaqcdvefBf690yjZNDMNoJ6nxymSUcrE
	 POkBHp79S4sYlzJQss+OTdDv9DLXgDJosAiRngmTMYUOna+PZoWfOCIlUmFj2vhxvbEu5
	 fClDRepuZFQLVfpZ9yPSip5Tig9tlpnYUlA9wLSd6EUBAibqMhe/A0vFngk8fVcazdxLM
	 /wqaWFu5DTksAw5jHvLXQZX49Fe5wG/qwpox3Q7f9iN61jPSiN333unEDutHKoLYPkbN8
	 /kR7bpFEtBi5vJ94joNXMJN9bkCutiAJChhvNbI9ZosSsXNAZeE00Gnm7eI6A+oxuWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y0+6fGtK;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED76606A32A
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 23:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED76606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Y0+6fGtK
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so4766568a12.0
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795476514; x=1796081314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9y8eBhUOHRLpdlPNcmQfoTOPtq1wEw9bOFKY5UXmjUM=;
        b=Y0+6fGtKfzRiIy22VIm94YinYILHytPcLerLONtHr/UvkiljP+uaDRyorQCf0KZwwb
         LmDBcM7tuwi9eHeUtoWAtgFZi+r+NVxuFpQKrFTNxdzhMP0oJmoqdhw5SZoDTXBya5es
         Q3Onc6jfosThu1Y3jKd8oJJgsU/c6qQKu+A6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476514; x=1796081314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9y8eBhUOHRLpdlPNcmQfoTOPtq1wEw9bOFKY5UXmjUM=;
        b=wdrFk6HVCgicpl7bjRht7gDTIv6obVV0Sozu6RIFQD43qgcvUqNLT9TFSQ0+JhrZzq
         MK4whJKv0IOmzieucwMwTpE/petH7AkiAn+VrlLIOJTYMNiOzvuXYHo0zzveP3ZThxrF
         iZF58H3Yt0eq/BMxPopL9BsNJLDPtK+3joMMOD+4CAlTOr4yNaJZfyBtn/jamtKMUD/P
         z22gIJ/siJeKk68bcwJ+SaKs+HlIVUP1fIconi9+sShZWJ/Bn73QCnSspZXQRW2/dlRJ
         Acb5h9HJ5SSz6a7cQgSmVEeNcWfva5afFMZP74xCnmzbN+6TrxWmk65EoCuo5ecZVr7M
         eOhA==
X-Forwarded-Encrypted: i=1; AL+hErGPN3ZvtdNF5gH2c73wxj0MAhHj8nHR/JLuaiqwXPHg2qZHbK4RHZty1iYfkIJ2+ibMprexe5haSdcQPb8/Xw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9QZoMpQjvK0UQpcTGy6Fm06vLZaEvnGj6A04GCNgmJ+le7ZPwA
	G9w9mCNCkDOAgMZDDdxnbXc5/UVT7h2juC8DtwnPAQYE4VC3zDW1eIlfsY3fUno5oQTsVQ9uWlp
	k79imEmA5
X-Gm-Gg: AZFdTZcryMWIWs1vCdN1FoKfZW0WxJ0apnhu+kh3fAKL7rIeF4mzkw5/DYwNgv1gqju
	JZLihxq5F3+DGEn4kALK5LBqb3i67+QY5gxrOfjHOvcN+/Rvg6k98mp/dmVSgYeA1VyBYxsJ3kP
	O/lAuOZIOc5jkowzmARpywHV1w2mOvTpEDb1wrjxMj3dgXKqw3Jp/1LiFxtuwfK+mx9fB6uKDiI
	zF10w77CMwNqprD8WHICti6J1mL+rOAPzHkLQ+s9zMYAVHQ82gD1OyFLP7GqPE4hzMCD/kBC1U1
	85kTUL6XtJ0iZd2IpAva8QATkImbC0T5VwefxmyNGZ7NEbkwT+MdVKTS2biFrzIJQEFz33rUx9g
	kAGS6q99G+mXimfzWwQZfwHp+DabAi/rSjaYTLVKHzyxEjVZZX2Am3h7WFhWaV90ZfyWR2yYsai
	fJ1/0QUisJM3yH+U/7pJAnYxcDWrsdxCzcJggKvfajWmXH/H5LDvjL8/kR14vXMlH94VY6vczZ+
	OtW8AZUQVK3QAYAjID/y2kkRFD1ME1QDatd8Ii/5nS5x+Osb1ncOWMgL65iAJj7qb5bADEmX7yO
	tcCAT+8qxs8BiAQmb+ethhFNqj3bxil5fQ127fdh8c3Ais7P0SMcMjZuHf0Rz+F9Dtgs
X-Received: by 2002:a05:6402:94a:b0:6b8:8146:a115 with SMTP id 4fb4d7f45d1cf-6ba37c7c39amr6923036a12.2.1795476513691;
        Mon, 23 Nov 2026 15:28:33 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36d730d1sm5976009a12.0.2026.11.23.15.28.31
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:28:33 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e47347279so2287542f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE7PYMJRKN+gDJ2EuF5UAJJhcff0kM6f9OYH9xgLTf/CUbrjVRbzDQyDrU0avyj/3IPtqehzCCYJlTm2WdIeg==@vger.kernel.org
X-Received: by 2002:a05:6000:18a5:b0:48a:f0cd:8712 with SMTP id
 ffacd0b85a97d-4abb7f3e149mr24759404f8f.50.1795476510904; Mon, 23 Nov 2026
 15:28:30 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com> <20261112031629.396819-2-mrungta@google.com>
In-Reply-To: <20261112031629.396819-2-mrungta@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Nov 2026 15:28:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wbg2NrVkRcF5tmkCKCaO68s02DSioZrh0Kef20bgoidA@mail.gmail.com>
X-Gm-Features: Aa3M54qxqk4ye-nzMXd_3z06vzEcZgIhi2oG8UCPyVLsWcK9JJNpK4as0MRwgIg
Message-ID: <CAD=FV=Wbg2NrVkRcF5tmkCKCaO68s02DSioZrh0Kef20bgoidA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] genirq: Synchronize in-flight handlers during NMI teardown
To: Mayank Rungta <mrungta@google.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Marc Zyngier <maz@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A . Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 11, 2026 at 7:16=E2=80=AFPM Mayank Rungta <mrungta@google.com> =
wrote:
>
> When freeing or disabling an interrupt requested via request_nmi(),
> __cleanup_nmi() and __synchronize_hardirq() currently do not wait for
> in-flight instances of the NMI handler on other CPUs to complete, which
> can lead to use-after-free conditions on module unload or driver unbind.
>
> Regular IRQs and NMIs require different synchronization mechanisms:
> - Regular IRQ flow handlers already acquire desc->lock, so tracking
>   in-flight execution via IRQD_IRQ_INPROGRESS under desc->lock avoids
>   extra atomic operations in the interrupt fast path and extra memory
>   barriers during synchronization.
> - NMI handlers cannot acquire desc->lock, and querying hardware
>   IRQCHIP_STATE_ACTIVE alone does not cover handler execution after EOI.
>   Track in-flight NMI handlers locklessly via an atomic counter
>   (desc->nmi_active) in handle_fasteoi_nmi(), paired with a dedicated
>   __synchronize_nmi() helper that waits for both nmi_active and
>   (when supported) IRQCHIP_STATE_ACTIVE to drain.
>
> Because handle_fasteoi_nmi() runs locklessly and cannot mask lazily
> disabled interrupts in hardware, force unlazy disable
> (_IRQ_DISABLE_UNLAZY) in request_nmi() and mask the interrupt in
> hardware before setting IRQD_IRQ_DISABLED in __irq_disable() (matching
> irq_shutdown()). This prevents a level-triggered NMI from observing
> IRQD_IRQ_DISABLED while still unmasked in hardware and livelocking on
> EOI, and is safe for regular IRQs because __irq_disable() runs under
> desc->lock and no chip disable/mask callbacks inspect
> irqd_irq_disabled().
>
> Update __cleanup_nmi() to serialize teardown, shut down and synchronize
> the NMI before clearing desc->action and NMI state, and warn if
> free_nmi() is called from interrupt context.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  include/linux/irqdesc.h |   4 ++
>  kernel/irq/chip.c       |  35 +++++++++----
>  kernel/irq/manage.c     | 111 ++++++++++++++++++++++++++++++++++------
>  kernel/irq/settings.h   |   5 ++
>  4 files changed, 130 insertions(+), 25 deletions(-)

This is a relatively big change, but IMO it's a problem worth solving.
I'd already reviewed this ahead of time, though of course that doesn't
mean I didn't miss anything, the Sashiko feedback being one example.
I'd be happy to add a Reviewed-by tag on v5 with the proposed
resolution to the Sashiko feedback.

-Doug
