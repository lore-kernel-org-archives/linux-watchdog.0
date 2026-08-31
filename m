Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A346DFE8
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200230; cv=none; b=ElfFmDYaf3rNqS2noMx2YINMf1UtzySSV9ylCEUpJJHj4Zt7m+F1wnbRmY2KK4sLBhFTO7XFElDpAu60cJ6SpXMeFOaYqdujINER7wtXzgmjDTLi4/SrbJ6J7nsGdZxzJRn6i0G8PMsQWEA+Fwt6hzgetc2Rb8nZEmEvE5808Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200230; c=relaxed/simple;
	bh=uuSQFEl0f5Xgmd+uvHvfUuQ50DstW+2uE4t8uSGFq5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUi3bBfTl0IECZpMZTp97oeJ8dsOcg7TxWOvQKm5ZciXVdrmtrb7DtI1IUDZyPVTmCZ5XIUKX8FmbkbBW62Al41zYTG92F/JCIlhpWyOpPFaRBYWRhlK6g9o9biERRDl1a7wLaCJ0ylON19JnXqwtH4s7DoX7O9Rip/GHCMZXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TDfnxHy+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TDfnxHy+"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2531f453eeso592261866b.3
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788200227; x=1788805027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0HEz6oOVo7hlt3+Pf50YPJ4GWCG1Y+vkc7cVq7puJWI=;
        b=TDfnxHy+pC1lDiJixMMspQIxNfKaeT9o46zrCn/uSPEC5xV4w7u0mQ+Wsm230or72/
         vQ3ib7wkWojYS9e/HA9E548DWfIhYy0jvAx25pklUMxGBXcS+Q1F3bsP8XnXZW4A8WWj
         BoAvBTOcYiWsiS4iK4Bw4XkzTlQQBVr3VwHEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200227; x=1788805027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0HEz6oOVo7hlt3+Pf50YPJ4GWCG1Y+vkc7cVq7puJWI=;
        b=azJKJi8Wk65dHssc5Sgo7g+p146mirD+s8qPY5FEgzGQuU4IUd5l/1rhJdvlNMz5hu
         KmCwXmwUBUqaklk+1PgHSYSw2FknEsfuXiKeEzcpI6GzX5icn2mEqlL/PNZTFZrQqi7C
         d041puyNU8ksc0+xFQUJ7syLhKpIoRxlIgZilAt/EbttLNaYJh8ZfGxKYY1GizFK/WUn
         BsBtIg7kIOYsPhHW5rJ2IOlRCvY6i9cE8AFRhEKG0CFOjgSUqJm95fOvRQnPdIcOZk6I
         O7it2DybmpFFBRePC7QhufxW5I3uXV5EjsMiplKMIm4pdYVINTWypBHMxWEF6+i4iCzo
         wyyg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6n1TQjpRpybyxmVP3kuNHhDX7tjuYfsg7LmDypFXe+dZdHYHD3VVfb+xygo4gwW0qdumb26kKFducZPw/uQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lcQYR77zgqwmIVXts44NUQxjDLdHnvGHJ+kiBa4SNi3LqIHOvz
	8ryXu+w8v+n5ShlxwcxqP9ZgcGQ27De5POfLnRUQBqxFeaEok4TukpHj0xr47Ju/Ho5xDTM5aWZ
	ymOJe9NcH
X-Gm-Gg: AR+sD13h+lzoonmP3dP2LuPGmfSLur8BUE6VOGjGk8AffWVInTbL8y/yvSAgKwEwmr3
	omCjj/+0xNY+jqfHPkqodI+jlkBEtUYWlPGtSdCVYtPc5SkjF/g4kx0gl12qmeipk9gXXnkJ9F5
	3UoSHYq2zGDv2AaR6uX1onPiokFEetzrueGRXsU+/dj1KZc+/RZHjjdxs359wI9BP7e1ucpOjkc
	AwGz/r2mKR9ouKMo6GSzvW2Pwy+B/0fk+Nql3PVezhvfPF3YDNVWU4Ty+faoKiPNBZ334PSBKqa
	2pAS0f7KL7YWEWyOEIXmD4/Rm//OL+l8phsV1icYMQOmqDQukmFnSKLvCJkmwOyPi41VxS3Ltt9
	o/3J0JOtK+kijzUtzPcnvMd4ZYyVKQIPWrLbo80F3L31UJgQPYyaD9aWde55gepXm4d41/D+so4
	Ps2xjqgDlsd/3MN1etB/qjN98Ze+v6jdWNOFMVrLr0o+LxypQpAP49EjtKSv6uR99bsPPArTckA
	VGbi2pE1bYapSi3V31dz28nw6IgSLxlwBgoJw==
X-Received: by 2002:a17:907:843:b0:c16:84dc:9607 with SMTP id a640c23a62f3a-c25b3d791f1mr142244866b.19.1788200226582;
        Mon, 31 Aug 2026 11:17:06 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2851csm479428866b.14.2026.08.31.11.17.04
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 11:17:04 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-484362f5c4aso1591272f8f.3
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUpxxnYmWdOHxyI0BvdLW54boimPpFNsG6LxGuSKWmvd2Am8MtYacxlEBb2GYfyOTC9FOdse4XsFdAEH4CRQ==@vger.kernel.org
X-Received: by 2002:a5d:43c8:0:b0:484:40e1:8c40 with SMTP id
 ffacd0b85a97d-48440fcda91mr3934528f8f.5.1788200223514; Mon, 31 Aug 2026
 11:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-qcom-wdt-nmi-series-v2-0-363979fe6b6b@google.com> <20260828-qcom-wdt-nmi-series-v2-2-363979fe6b6b@google.com>
In-Reply-To: <20260828-qcom-wdt-nmi-series-v2-2-363979fe6b6b@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 11:16:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xgq2aJ1wPFggFBT5x810xZr33GOtyJDvhYf74CmuPUKQ@mail.gmail.com>
X-Gm-Features: AcwNN1VE0AERlOw15wusqCepTJcCXi7KNdMxoGrnxAOTT_pd3WQ9VGal9zL8yXg
Message-ID: <CAD=FV=Xgq2aJ1wPFggFBT5x810xZr33GOtyJDvhYf74CmuPUKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] genirq: Implement synchronous disable_nmi()
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
> Currently, disable_nmi_nosync() is the only interface to disable an NMI
> line. Drivers stopping their devices in process context need a synchronou=
s
> variant that guarantees any running instance of the NMI handler has
> completed on other CPUs before returning.
>
> Implement disable_nmi() by wrapping disable_irq().
>
> Assisted-by: Antigravity:gemini
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  include/linux/interrupt.h |  1 +
>  kernel/irq/manage.c       | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)

This looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Sashiko had feedback [1] where it was worried about tightly looping
doing HW polling. To me, that doesn't seem like a big deal since there
shouldn't be many NMI users and NMIs shouldn't be freed often. Perhaps
Thomas has different thoughts.

[1] https://lore.kernel.org/all/20260829011853.0B9A41F000E9@smtp.kernel.org=
/
