Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476539;
	b=VG/yCsQGJMxSsUwmb9E9kQ/o5tPRMRLYCbLqU+K5n3f/W+a9Y6SWprXXRZGdg4q5mjVh
	 zFEHsA/8xcTuq5Lponapgo29w7oS+XEWwP4TQwbAB2soKiDiacbPzzweWJSk2oHWtPb9b
	 BJTfjLrzx5WbF9WZYsQeKPNU15kqbqnLlH/aoGZEGt9jqpQzyv4TJHxXi0LeWGyRGDo7r
	 QuHZsG11Eif1KUFDwonyV4y9oIgrDe2h0MSk5WziYpBweQRMNiftMxkn1VkEeNf+TYqjs
	 +B5KbKEBmlSpP2NWm3PcHO8w3UK2oV0XhGWyOe/AJZ4RaJdXrAUJsYKeV3hyuELgdWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rpYvPmxHqeKMEWXcXjP8ETFzglI6N3DO0hpa9d/C1iQ=;
	b=XYvyvRr39PN99lh+AgzoKy/jF1TPZkniAA0HH+dO6av/bahzXNwfmzT8ZQ/A1DoubMfD
	 CsoYVA47cuf94CS6kSbBWkOxktxjp9KnNDLmkma7MqJZ22Xl4hRx14Os20H6jXYIwqUL9
	 hF23T27tohwIpJMlYcRZDKN6F44duO8p9vn26ImlN9dNDlD0hwcMGxo9uqtIH6y86MP1J
	 QUSVDPvCz1Tuoz8xb0+EXAO4Iw5h7qrIbHYYCi7szaAefndpggNOoI5ZuA68seKPI6aU3
	 lKm/UXLJz33dHIv/iDNUdMsnT1U/nCIJL/gRrbgNQrNM6hpn8AH1WHX69wmvLFDRgdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YjnyPR7Y;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47796606A31E
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 23:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47796606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YjnyPR7Y
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c515319dd89so448592166b.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795476538; x=1796081338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rpYvPmxHqeKMEWXcXjP8ETFzglI6N3DO0hpa9d/C1iQ=;
        b=YjnyPR7YVly0s5R4EIOAOSrlZqToBo6tlCbIW7tEFfNO8XxT+kAql+AcVaCHqX8Djv
         +TPIaDD/OrWeK6+xp4GGl1PcwY2AgorPwv7WPoZCJEk3d/mwOr+hNeylYg03a9XKXtGm
         Nye6IMMtXFUt71NOxSeCwoELF4NXtW02hF57U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476538; x=1796081338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpYvPmxHqeKMEWXcXjP8ETFzglI6N3DO0hpa9d/C1iQ=;
        b=lbO55FR2zCnlmievdcDSo6WBXOpExEHkVl5EuX4Nu7UG7HCwf4AaWS2ssCpJxMejGp
         buUUty25K03WcCkE21Gj+yhhRiK9txktGks4bpqg/hjNcyas3onaER5V333MvsFnFi3a
         NSoFZBjemS9Xath1nFqpn8MLuySRS6+xR1clTd5dkwHt+5mxe1gnQjTv4HeBhuklFDAX
         5xjr0U+0L9tw0NOR4GjFolNBoRqox98eClIK0RxVN2UPBQ60C4wjFMsKzvEwgZz/G1cU
         fVa5xPUIdMTM2uCNWN5yN6zi67NrAJ59zZTERgcPVUj/rGQ7aRczFDe4DfB/rGfA7iCD
         0iFQ==
X-Forwarded-Encrypted: i=1; AL+hErEYvi4fcgGFtNYe036MM7Zs7LmMKRmrBLKZ1qkLm2wojXp7h/zREfd09OkvP/XcnJqN4057AAaMuPuYiQcBMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+OiZUD0zCu+h5RZsXO/PysJxQ/a2HejgvnOKKz17GKfcw30g4b
	qCSrsS7xIX93Ytv2KPGHnIGFZ2u34eCW5Q2qdBnjqh+3a7aTuCoGgIYWkvJ/YH0Go5hTIVxxlxE
	jPSFP1Jb4
X-Gm-Gg: AZFdTZe9fJPjrJ8UxPkXQDGtDPXQbN+bKQ7bSuUKOvbYkf4R+rX7TXnW7G4Ft+ZeXQs
	KbW6Ewktf0+ZzvDhztYsv6fT1rUU+Ui7wOU8lg2P3F7TZ6V70Zk0RBcoKj+EJNwppFHanWgYlVW
	QBdZdy7pXLIVzCOBDI0auKzz5hzYefizG4ffl4p5yDGxFyHDgPgkMg4V230644r2xztRC3lbENm
	xzkoAwopEvZP+rzbL7c/Cd1mzHF2LNCNz2ecHi94xIDr2Lh9h5PPYJhQOT48ULqgC2rQ1jRnkL1
	2CvK9WZd6syvR24HdniJ6pGTZEDtwWSoJ+Dtz4pRuSVHchv6Qsmsxxo41ywGcC4MtRHMzRc8cUx
	xTBQATFNyFy2Q6MR/sZ9w9oBVgiHR39WtChAOk67x038DAkSdfWE22G8tIpGvZ34EcAf4KM1W7k
	Z7s6T+oKnICr1hTCOsADGo56fWU+XIETbQYsqepObXSWnwt/IMs0kK66bcCno6KKXquNsCVFcW6
	QcjOEu3NxEIhvZfcmXsAy3BzD17/go3GjYrIfjpEsbWxsRyHQSjI63sWs3NKOzqaj62sWQtr2xI
	YMxckRq7p7kYu93O1pEBmxxXyB9AWcwRjCoGAUMDV+bUc3jM+GzeFoSpC+rc1MiTAx37
X-Received: by 2002:a17:906:d553:b0:c4d:906:e979 with SMTP id a640c23a62f3a-c513a420146mr1063043966b.3.1795476537672;
        Mon, 23 Nov 2026 15:28:57 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea5b9dsm450545866b.47.2026.11.23.15.28.56
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:28:56 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1796173f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErECT0jxea51TI8C3fuFWDPVNWK0mKREPHMkdPPjjWWx6GXtyHWzfm3sx+xN1LXF8ra/jb+RE5iEfIei9EqrvA==@vger.kernel.org
X-Received: by 2002:a5d:5846:0:b0:492:e1a6:90f9 with SMTP id
 ffacd0b85a97d-4abb3c37b61mr23717515f8f.18.1795476536084; Mon, 23 Nov 2026
 15:28:56 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com> <20261112031629.396819-5-mrungta@google.com>
In-Reply-To: <20261112031629.396819-5-mrungta@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Nov 2026 15:28:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U65s1rzG=VqbRur-UdcMf=6rcjMfoXbOBtyiw1jAyPgQ@mail.gmail.com>
X-Gm-Features: Aa3M54pAb5UUWg8n7puuFK8qjUeDvkCKqsnby00WFwsuj_cqspTt6STuvC8TlBQ
Message-ID: <CAD=FV=U65s1rzG=VqbRur-UdcMf=6rcjMfoXbOBtyiw1jAyPgQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] genirq: Export NMI APIs for qcom-wdt
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
> Currently, request_nmi(), free_nmi(), enable_nmi(), and disable_nmi() are
> restricted to built-in kernel code because they are not exported.
>
> Export these symbols with EXPORT_SYMBOL_FOR_MODULES() restricted to the
> qcom-wdt module so it can register and manage its pretimeout NMI when
> built as a loadable module.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  kernel/irq/manage.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 073fd3595d2c..ace4d2796382 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -852,6 +852,7 @@ void disable_nmi(unsigned int irq)
>         if (!__disable_irq_nosync(irq))
>                 __synchronize_nmi(desc, true);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(disable_nmi, "qcom-wdt");
>
>  void __enable_irq(struct irq_desc *desc)
>  {
> @@ -919,6 +920,7 @@ void enable_nmi(unsigned int irq)
>  {
>         enable_irq(irq);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(enable_nmi, "qcom-wdt");
>
>  static int set_irq_wake_real(unsigned int irq, unsigned int on)
>  {
> @@ -2189,6 +2191,7 @@ const void *free_nmi(unsigned int irq, void *dev_id=
)
>
>         return __cleanup_nmi(irq, desc);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(free_nmi, "qcom-wdt");
>
>  /**
>   * request_threaded_irq - allocate an interrupt line
> @@ -2455,6 +2458,7 @@ int request_nmi(unsigned int irq, irq_handler_t han=
dler,
>
>         return retval;
>  }
> +EXPORT_SYMBOL_FOR_MODULES(request_nmi, "qcom-wdt");

The patch is fine and I'd be fine with it landing. That being said,
looking at this patch with fresh eyes today, I think it can be
improved. :-)

I think we could make disable_nmi() and enable_nmi() simply
EXPORT_SYMBOL_GPL() and then only lock down the symbol for
request_nmi(). This means we don't need to update 3 separate places
every time we add a new watchdog driver allowed to use NMI. People
can't (properly) use the other two functions if they can't call
request_nmi() anyway, right?


-Doug
