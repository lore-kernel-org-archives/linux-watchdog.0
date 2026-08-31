Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F446EC6C
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200250; cv=none; b=N0AmNS7H0TQtAJ1eO8cXUUZNSIALljP5qCyT2SXbkI2vzBetoHUjudcJkkBsO/N9XjXK5RsMvVOqm2khA1cxqVQgdn3o7VXN77pVu2btW5tfSttfdCR+UeHVT3oLevsD0iUJgTnahDAb4v4eFpyyG0YjPcjrnKooeIojDZUdFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200250; c=relaxed/simple;
	bh=D0gY1RFo3fP5F2alggX1eKdz74k3uW88LC29EILOh/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3oUnNz59e1jo1V74cxK68ogXLzMkl9fVkOGbhRsznKr90e8e1jljjUR5AL3GdUyR8LzAAxQXhQ9lFJa7fNIlsTsGMSm+PbojoTlIxBmLtS/UB9HmUDDJ8YqdqkbQV0njcq0htKHGk2EfQhg7dEIbCf4uaYP+JXS69aqNy8DnfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EaDoorwH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EaDoorwH"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so500233566b.2
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788200247; x=1788805047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YA45RBK4xNm5is/1vr4qQL3XM1GA4yJrufiy7l4ApY0=;
        b=EaDoorwH+gRzG1hKcDdi/jWv5A+g/q5Z7vq4rVzTyrx7H6zSX1Hg36qQo+PLF8zM/K
         2kfzbiXSOiNZLxq7L7Qv7DphoJEV1Kv6w2lX0FGnIDG+fw+SlDg0shUkiED/dszd/opX
         6S5Z57HlLkFuWJnVsgRvMNuh0gsmE0xpS+G1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200247; x=1788805047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YA45RBK4xNm5is/1vr4qQL3XM1GA4yJrufiy7l4ApY0=;
        b=RETtJsSnlJWZ+e9IbB0XLYhtxIGH4Wq4M45EMEGKwaRJVxRucVPp46qA/N/uA2kV2m
         8Mh9Etep8/zkedkIUnoeJntAs93gwTumwcJtWs9j1lcJIu2eYPGVNPrAk7nAC4wEo03x
         QPh3CFHYtXGjO3MAUBOoGYUdsAh6ecPWWmioiTWr1Z25u+wLZK/sUpHjoyYNsrszCWEX
         EldbGgipedJoO6ig+y1jkhsvawenkbPQ+bmR7+2ALQ9MuNmTkQ9VE01mLOwop8QwOYa0
         iUBIaTF35vrxA8aE9JpzfRkcX3TXnJJIAHf9/+o/J9x70qnz4j2M4n88h9ugpnKWvHDL
         042Q==
X-Forwarded-Encrypted: i=1; AHgh+RrqxBWmOGA7h3ECDyH0pt0SldNw4xSBDOXvE/fNFmarZLnRWRKhwOLfpSZP09jQfRVcWjpdhmqwLD7jnKHNRw==@vger.kernel.org
X-Gm-Message-State: AFuF++m1eRNaQEcjDYrnmb0TxF3BXIF5RFhV9QbpBv9u6VwdOg0MVtT6
	iIBC+qsSqD2orTVeY99HNK3XY/RByxltNUiA9fQ8qI31ORj44K+pClEL/OhbbQl2UQy4bK9r5BL
	LZossSo9N
X-Gm-Gg: AR+sD133PoQX8PB94F4zqLCZsqHT4xVHeyc52wq31a5tXsY9CJjp3zDpWU2Pzjlm/j5
	wcyb5dG934gv/0qpgzqsa5MC73mx9nYgJmrPJNPdccltweDrSL82kHtPLQNvC3z+9aXBTdFQDlm
	or1aMGiojJzxyRQWb2/5qW3kUOpT1fa0yl1FYcKngv7JXeI7Cmod0V8q6Kn8DHG/WuccmbSK/zZ
	gFaqyG7cRmWmNKcAdci2dgeHB8HS2LsRrzjk08YoYtV0TfHJFdyZI1YnSjBrwqooi/k5h9esXen
	FsfT6mY3aJX2FFKqiECI5Y3mwhtwwFxyo3XHinZcjUqcqJO41dl74BgpspzwIhKl5XXoSckWdTB
	0ckfb//mKFG2bD2NXNERvzzF0xado2UQt+1tEp2Ok+7Uppbw1bjYHuEgEHa4WpQEcT3GHZNJV0t
	BWYdw9dxw1AwrXTP+Hc2AA2yeJPlaeKizoEeqSyP7AkHEg4hzX1sBBD0Oav7vyvVRjSUP1XzDP7
	JDS56BUJ9OXEIF3Vn5AA15rbmyC6MjqkwB/LA==
X-Received: by 2002:a17:906:7315:b0:c16:13e7:fd63 with SMTP id a640c23a62f3a-c255679cdfcmr1730931666b.0.1788200246826;
        Mon, 31 Aug 2026 11:17:26 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2049sm487483966b.36.2026.08.31.11.17.24
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:17:26 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-484415c8bf2so36324f8f.0
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzYCgokGFoNk6NtnPzoi3mV0mwNRMu9JDCvSrlcmh839Yb52KcmrdlSBg8IarYj3h0aUecKVnpOrYAcDyHD3w==@vger.kernel.org
X-Received: by 2002:a05:6000:480a:b0:484:3311:af37 with SMTP id
 ffacd0b85a97d-4843311b2camr31399850f8f.26.1788200243898; Mon, 31 Aug 2026
 11:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com> <20260828-qcom-wdt-nmi-series-v2-4-363979fe6b6b@google.com>
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-4-363979fe6b6b@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 11:17:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V+vbapkDzby6f7BbjSuSHc9RFUVejCf9dO6xmzuPE1Lw@mail.gmail.com>
X-Gm-Features: AcwNN1Uum9nPWl9j-6K-ngg8lklWL2dpaMcNuBtk2t_f-Opra6jTlnvJ6qWwoik
Message-ID: <CAD=FV=V+vbapkDzby6f7BbjSuSHc9RFUVejCf9dO6xmzuPE1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] watchdog: pretimeout: Protect governor access with
 RCU for NMI safety
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
> When watchdog pretimeout interrupts are configured as NMIs (or
> pseudo-NMIs), pretimeout handlers execute in NMI context. Accessing
> the watchdog governor via spinlocks in watchdog_notify_pretimeout() is
> unsafe in NMI context and can cause deadlocks if an NMI arrives while a
> spinlock is held.
>
> Protect governor assignment and dereference with RCU instead of
> spinlocks, allowing lockless, NMI-safe governor notifications while
> preserving safe runtime governor switching.
>
> Assisted-by: Antigravity:gemini
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  drivers/watchdog/watchdog_pretimeout.c | 45 +++++++++++++++++++---------=
------
>  include/linux/watchdog.h               |  2 +-
>  2 files changed, 26 insertions(+), 21 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
