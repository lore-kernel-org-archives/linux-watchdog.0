Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D63B14AF
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355120; cv=pass; b=Eh4A82qfqEI8PlCEk8wkEpanXtCkEkF3C+yke7StYI4gXp1OFH6NWZGxpJN7c3EEMNQ6D2gBUliOqNhCJt249vDHbzBCWB24XmebqF22GoPfa66ZUS7bRaF4Jtqr59JstH84hhQuEi1s96dNoJs0CVq3M5sXRhK21P0OwY9VpXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355120; c=relaxed/simple;
	bh=jzMCy/aLy3IlJ2KgJIlg13IO3drPxZSWHo1bEnnokMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPw9lj5aFi/wFamzmcKPQUSKQEkl/+Eseg+Wj6zOQYe28PRROQCQTKWfYZYIoFNXhUkyk7B2aax6ZB7aUfnnnmlmXVUxu9Xkw7CSjl6k6LX1a1S0UvkBtON/fUrZJdmu7nreZq1rznMG1VR5uxfe/Nm1vvfhHmJsqoM/1Pvm11Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rn4XbKP9; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn4XbKP9"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1251900a12.1
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 02:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786355118; cv=none;
        d=google.com; s=arc-20260327;
        b=Bo4hI9kE4DK5s82ngqg3qosRHmbMVuGLHMI16KuAS7Memhpk1+WsGB9PVMjHeziQnf
         ucJzSUJRV7JjjPBBBqU3/shW4z5eWbpWYYa/YiYxzYAzqy+ULjyWkvzpZ6iCKJkDfdDH
         nQ5U9+ovzRrvMyE4UGM8xBMe277CU7pDbUFsj9LbQOWa9j9uoEi0pnmC4s7is1uUtKzq
         bN1YNkMuRCrm2IG5yuJulTzB9lVYOpAE4x3RCZnJOgcJugDwxoRwtGXpPiI4MOdjfuXz
         c7NemLGEfBHvB1bqRPvFPdcMP/aVBPGWvxuDQQxggYNYwoUhvpWP9fhW3GEVsgVIgQV5
         aHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
        fh=6a3L7TcvZZAPDza8tad+DNZ5+f/IFONMA94KHjt65cY=;
        b=rioI1it1USlilQ1kvlWfSaRoWPUeexGRJyuKhOsFSoSCzSGSkmgrbTIAMGlt1pAw7w
         ePEjy5XGE8TuVbhsRWWAc/D3FKYcAI88eXt72sRdlLxT6MTpnLQ7O/FSAMXJonsnWGRt
         Z9NfMbLDXXMvqyt0qjYiFvmqQa1gBRa4eIoSeGDV/ncUCRN6f7tZLaawi7eWVLqKrBqB
         imYq/LJ3b1zMTIq2yz5Fjb3/nNAivmvMnkPFfyE5O5sBlLKmLY/zjShcNHS2/2PFJhCn
         UicL7nM+PeFXR/iFecHmZiSCvmNiTspwqbFIY8zbOIDBVFParnnzp3GrYBr6rz2Gu385
         eLZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786355118; x=1786959918; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
        b=rn4XbKP9oqEAsFF5QoLm5LUupWkJ+tGB4Z+LsptV1RSZy30uIvRblTNQQ9PCY26+KI
         2wb80wD5pR1P/86N5ZRib4UkgIJ2qZAARcaNGHBau8pBaWXBD3XLn+Clva7zoI6BA2mN
         LHgpF08f52jjSty2TAo2bYxSxg/JhhoXw2o6WxDG1cuRMRfcDPlVIoeryOYuokkP0PZn
         ssjIWZR87HD338itpaWgNhlqC5buQiivg45D2MbB5N0mrF/DWxBYNooClkILZyUYzKlY
         FHFWgMk/0Xf4Pee9BmnTbk+l1b9E/mBqlnrFYuW05J5ck+hXmK6pyUwY641cT1PzhJV8
         4mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355118; x=1786959918;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lEhjsMWG90vKMNIv0q/NvqRJMIZC5Z2HAc5jYXUw3Vo=;
        b=qYw92q1ryEtgZwW6Nxd/C5HpCfU3bpFV5mTwkfvLc7v4nzX6SY42No0QvvXjmYZVzI
         yf1bX4sP0kIIZ+jRGBUsOsssfx1yfeFWp81wkZ2Zpoo5ZFwfGqpBDjTXqLVomWoo7RyT
         zIFEnrSJdEoHdfkz196hoRAfVbwwhxTORtXQIqZwb2OjgSYMTYCbCGC2htH05sg4qzR8
         +XI3mPRPVA57Qbc+Z9SkAam2dGkriJj1DfesSpjVjy0fs7GOL+q/O4ohFqgk5K6IFH0J
         K7YBvpAC/9A5x2zLabzaqCMotwSkvFJkGijZyl/yMN2vsE4o8amnxaEO7+r6FA2kv7kE
         Remg==
X-Forwarded-Encrypted: i=1; AHgh+Rozevv4m43ngAOcUy2Lnl5w3Wy27cAKWhR/Cr3f8frbjVrF4O6DNXIsiN0D3eW+y30jCT7wTgqOvXR8dwXv9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7aNPvM0hdJjh62bL9gyQNWWz0O/6Ys3rO7GL0d8ZqBp3CKn6F
	YvfIfSps59c7HTcKwt6WyeYz2kKgNMTd/Ipm9pczRZ7Qe6L3tRSSOxIrscNkUh/bWGhCTxLInVl
	p0cWA+1kRw9DVPXGsx1BtJwlq3YSvtCBLxY6B
X-Gm-Gg: AR+sD11+GsI+BGupUOrTcd6fsBESr+u+/Uufiinr1n60tPUon6aqRfyUfBnh1ELH6rd
	J6ns9wjionfMHvG7Kt/mqRQ1H17Yi6QRk1E0V+tGex/GbEmkdjS0WPyOp523qV9J1PQB0sCpvrF
	gvBUfolvbkINg4UCvymOY3sE04YAnMTshCGH/JnrwlM+DDwBmOw0L5lTkC2fW/zh8CnGRdhpOSi
	riOK2B8DcSHAm1uzSUtiZ/lj4y/YWD9pdFUbClTmeU/NFr9nhQuIplo0BZ2BjSFutFBz7RBBiDU
	cz3b/Pr/HMB8jY/hze4/0XhLmALmBNZKfrdRTQzvVlY0xra7IophbSWT58dQCrUCP2+nvXlpgIG
	fQS3c2lodbBAZWsxayMaZ47dj+odq0/WTt4Nkf8p0htDeA0volMrHTvsp
X-Received: by 2002:a05:6a20:4309:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cbce930129mr18884836637.29.1786355118398; Mon, 10 Aug 2026
 02:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net> <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
 <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
In-Reply-To: <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 16:45:07 +0700
X-Gm-Features: AUfX_mzy3FMnWBW1ZRsEZF6RiTcGKaOh9JEcD_RNAR4jnG-Nka5rge-6f-tSjWo
Message-ID: <CAABR9nFcitFyS_xZUkreHWp822iVsoEg6ONFwU9JwPaBqm2MTQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,


Thank you for your feedback.

> >>> +                     return irq;
> >>>                if (irq > 0) {
> >>
> >> This if () is no longer needed.
> >>
> >
> > If we remove the if (irq > 0) check, irq can be -ENXIO and would be
> > passed to devm_request_irq().
> > I see that the irq argument of devm_request_irq() is an unsigned int.
> > Would it be safe to pass -ENXIO to it in this case?
> >
> No, sorry, I was wrong.
>

So this means there are no issues with this patch.
Patches 2 and 3 have already been applied by you.
I will temporarily resend only patch 1:
" watchdog: qcom: Propagate errors from optional IRQ lookup "

Best regards,
Phuc
