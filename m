Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F613D330C
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 23:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539921; cv=none; b=VBtvhYNXBzrWVbDLfTyDzB4e00H6nT/uFqOtzRk7mQcAiEQixNTrBz4f8EeJ611WC6KE03sTJ1MeMFE5yYGi3Z7EiTn6VqmiFigll5xMDt8ehcIpjfIrrnsvfHHyBixVVg53J/6JUv8+NVNlaeLdAPNuUti8HXF4nxTjUihUxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539921; c=relaxed/simple;
	bh=piLOrm8QujBeaXbtopyNtAe+FWUs9JEGlUqoE/A+WWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkJ3/OvwSy9L3selunEeUDxt13VEv8feUjJh+v0zcQ8ojfHiRlrJG38KrdgNDrUZhXnnLmDDXJA8VT6o4ykVz648uzhEXwjCrKKfmK+cdN+AVpyoh94E2dXTU6Sz0ymCcUlPQSEKteTZ/Bhtileu28CKnSBQCrTkIb116vbIwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UzjFtRuN; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UzjFtRuN"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efec2c28f8so10807856d6.2
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785539918; x=1786144718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wMNXqyCOmkYNRv72Rrj9uzXvfgzuwGFQnDJXnRWaJkQ=;
        b=UzjFtRuNO8Vl/Vcx12le+F9hDPI+KM5lAkRrKLdeWcdeCAQStuKatwDImv5MxRcxfK
         4r8m3P1qQUmg6Hy2BP0I5w+IjYVgE3wRjDc+InNZaUxaXs8E2kU5vvG8J4W+KQ59s73j
         ESNlbw2IOlavWuzwCTP4G3QYosz8o7l+wulZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539918; x=1786144718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wMNXqyCOmkYNRv72Rrj9uzXvfgzuwGFQnDJXnRWaJkQ=;
        b=RcxjkxRa+k9Bo1aAg+Ryc8vOFQxIT6KTQhqj2Lhgf3wwDqu2YtuLAJyPHRJpJssIZZ
         YTnGls+z+edBOLJnyYDaCjzhE0exjU2dRpV1uDYfThW1pZBiZL526EJ8YYZXBK3RgKsM
         HjSRkF2Eayv5jhIsle44U2WUKBW4AwSheNrYZZRog0wbZRm6Gidz/VWIAtao9twnWPhT
         lZe/3/vPtptPBEZeWrpEn/gVtPqcNXA7aNplvCmVF8IBV3j1p/2ROFkmKszklCr6m+hO
         vvEh4NzAk7pdg9/NJn18j53NfLNegm/XegAoIE+XlpXBVjEgnL6yH7dJbp9VyIiRuFQa
         YNAg==
X-Forwarded-Encrypted: i=1; AHgh+RoqpWcvpSJFnpUs+44QQ6nkW6mro0fBkZbqurJCbVQQNtV5kXXcOzlXWtGVR32Hcb8eM+aQn1nWGPwwyNnuig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGQPJu/sW8/MzsSLkYXXxXbARfYiCI5Wi4+Iz3gcgTn0hWTM6
	WRXaBeYXqmQz/l5cxxbzpc+FSXlSuxfqfPI09PTAt8N4Pc+rK3j61vZHJBgiV9qY1CLpd85Uv0T
	tx7Y=
X-Gm-Gg: AR+sD1339nZJWr8QLHeU39WHY5s8Gfl2zpoIL8P/qPVNOZwf2Jpplcb5IyfFGHTdpEM
	pAPD7HEe3hnGRYOFqbyRK5iTc107SmEKnInj6LIfrZU0LvgmT1fgT+QUBAVQSMnWPlrNHX48Vae
	eVxei78dQc0t/jnuiGWDrd8MqcQ+kO91VVGtwr5sYFW5K05MVK4+GHQ4ndeGUF4ZQn2J/4hWZM1
	hEHYkVO+29AWSsTjaEaVEZ023AhjXGp+OrnG36Pt33k4ARVrEWMIWWWIY7Ve5JmoUoeCBxdS2pX
	7eKwBg8k5q0o6fmR/Yhxo2Vw/R7LFfUnAZL/lyDbsB6BDzcFl9N8DxbN7hCeH2dp9OhaB0DBDrq
	lwJsfm+ckhqQODtxUS40w5ZROTWCr0AiZJV2LgogsDjGoqxdN1yI3e0b0/BymS0/OkWN4gC1PBf
	Zyraj3bkJCRs3JC9msZw91RTH20kNKTeFpfHwSieUIG338ipkKQ4x5vj1TT5AvPJonuDYv3b6Ji
	ZP1kXiA/7xB6u+VpJdPmAIGRviTVBE=
X-Received: by 2002:a05:6214:19e4:b0:907:b32f:9b7e with SMTP id 6a1803df08f44-908495d123dmr36376616d6.11.1785539917981;
        Fri, 31 Jul 2026 16:18:37 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434bdde2sm21052196d6.22.2026.07.31.16.18.34
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:18:34 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92edb12cdf2so105451485a.3
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 16:18:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrBlpKdS43ae3bkjRluvl88rq++90sbjVEevWJlF3FhINFPwEQJwhvkAipdVcHrwGPPrTU0BYz3a+GB27jdPQ==@vger.kernel.org
X-Received: by 2002:a05:620a:284e:b0:92e:db1f:185c with SMTP id
 af79cd13be357-934a0aaee08mr439271285a.43.1785539913417; Fri, 31 Jul 2026
 16:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
 <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com> <eddc90dc-3223-4356-9e9b-350af904b144@roeck-us.net>
In-Reply-To: <eddc90dc-3223-4356-9e9b-350af904b144@roeck-us.net>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 Jul 2026 16:18:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XuCHdOv8kct63JzmbgjxJMxL7fc75KtAQL0hbJc7_v0w@mail.gmail.com>
X-Gm-Features: AUfX_mysgNutKcBTutK1mEbZpcf0AlDHDz_V7ZfULfi6icv580614osxqcrqNlM
Message-ID: <CAD=FV=XuCHdOv8kct63JzmbgjxJMxL7fc75KtAQL0hbJc7_v0w@mail.gmail.com>
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
To: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@kernel.org>
Cc: mrungta@google.com, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2026 at 3:55=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 7/30/26 14:49, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jul 30, 2026 at 2:33=E2=80=AFPM Mayank Rungta via B4 Relay
> > <devnull+mrungta.google.com@kernel.org> wrote:
> >>
> >> From: Mayank Rungta <mrungta@google.com>
> >>
> >> Currently, request_nmi(), free_nmi(), enable_nmi() and disable_nmi_nos=
ync()
> >> are restricted to built-in kernel code because they are not exported t=
o
> >> loadable modules.
> >>
> >> Export these APIs to allow loadable modules to register and manage NMI=
s.
> >> This allows watchdog drivers configured as loadable modules to registe=
r
> >> their bark interrupt as an NMI.
> >>
> >> Signed-off-by: Mayank Rungta <mrungta@google.com>
> >> ---
> >>   kernel/irq/manage.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> >> index 2fbff2618a1e..fb0b8da32f4c 100644
> >> --- a/kernel/irq/manage.c
> >> +++ b/kernel/irq/manage.c
> >> @@ -766,6 +766,7 @@ void disable_nmi_nosync(unsigned int irq)
> >>   {
> >>          disable_irq_nosync(irq);
> >>   }
> >> +EXPORT_SYMBOL_GPL(disable_nmi_nosync);
> >>
> >>   void __enable_irq(struct irq_desc *desc)
> >>   {
> >> @@ -833,6 +834,7 @@ void enable_nmi(unsigned int irq)
> >>   {
> >>          enable_irq(irq);
> >>   }
> >> +EXPORT_SYMBOL_GPL(enable_nmi);
> >>
> >>   static int set_irq_wake_real(unsigned int irq, unsigned int on)
> >>   {
> >> @@ -2080,6 +2082,7 @@ const void *free_nmi(unsigned int irq, void *dev=
_id)
> >>
> >>          return __cleanup_nmi(irq, desc);
> >>   }
> >> +EXPORT_SYMBOL_GPL(free_nmi);
> >>
> >>   /**
> >>    * request_threaded_irq - allocate an interrupt line
> >> @@ -2342,6 +2345,7 @@ int request_nmi(unsigned int irq, irq_handler_t =
handler,
> >>
> >>          return retval;
> >>   }
> >> +EXPORT_SYMBOL_GPL(request_nmi);
> >
> > This seems reasonable to me. One thought I had was that we could
> > possibly get by with fewer exported symbols by changing
> > disable_nmi_nosync() and enable_nmi() to "static inline" functions in
> > the header file. That being said, what Mayank has here feels slightly
> > better to me.
> >
>
> I don't claim to understand the NMI APIs used, but Sashiko's feedback
> seems real to me. Someone who knows that code will need to confirm that
> there are no unexpected pitfalls.

Since Sashiko doesn't reply-to all, here's a link to its feedback:

https://lore.kernel.org/all/20260730214758.DBD5E1F000E9@smtp.kernel.org/

Indeed, it does look like legitimate feedback. While the problems are
pre-existing, it is true that exporting as a module could widen the
exposure because the code backing the NMI handler could now be
unloaded.

I did a little bit of AI analysis of the problem myself. As far as I
can tell, it would be relatively safe to implement a synchronous
"disable_nmi" by just calling "disable_irq", much like is done for
other NMI functions. The caveat here is that it would only be safe on
IRQ controllers that provided irq_get_irqchip_state(). This is because
on NMI we don't set IRQD_IRQ_INPROGRESS and thus
__synchronize_hardirq() will fall back to calling
__irq_get_irqchip_state(). If any controllers supported NMI but
_didn't_ support irq_get_irqchip_state(), we'd silently skip waiting
for NMI completion. Maybe we could simply make it illegal for a
controller to support NMI without irq_get_irqchip_state()?

I guess maybe we need Thomas Gleixner to weigh in on this? Thomas:
should this issue block Mayank's patch? Would you expect him to
propose fixes as part of his series, or is this something you'd prefer
to post patches for yourself?



-Doug
