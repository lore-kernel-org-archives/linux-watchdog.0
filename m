Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148670808
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962412; cv=none; b=J3zuuiuseZ284elpTFkbtyihWGrQUbX5/NbJwEiI1/bYAnvwvdxjaUwQp8GgPjEg+2eZctYxFjJs5sXoMKbevOhknO00WjkugMu4PXAC9Oy+aKOGSjijcTX5QBNP6DG+DzLkoErCpoSJD6wuC+dVX0uzfIgf/BJPa4TqO5Ii8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962412; c=relaxed/simple;
	bh=Ez3ZpqdCvYLOlF5stVSUQnie44SipeV6ZSAHRGbEHzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gp8TNDDQ2KrlpTA0IjukjwmRlHmXjs8xGbM3jOFAZ6/4D7ECWngw1ZFhOLdjopOmz1lUbUKIrTtBCJUV+fEFReM5JYnYP5BLn+t7mQ0yukRiRoh+GJy9PIQpZ8sm0UvMHSD4IC9bTZsWijCvmvzl19cjkR5LZXIwq7yBlwbvX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhBtuscz; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhBtuscz"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66062a414fcso5411387d50.1
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780962410; x=1781567210; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDhk7mb9732ct0z/PfRvTx05SqomPqvS5/mzVTKaoG4=;
        b=hhBtusczVhYVtnMCRjT9mspXnv3ErUVd3qSUwOHhPHvTOtq2koXMO/0kAxSGQkyU4M
         935zMcN5vwVptqPBSERlBQ31a2Yt96KDGyk1OwwCEwchzbZ2aB5DnG3QUR1TRUndgVAi
         zHWoda80qjKhcfulTDpndsIQrfAUt7V2REqa31sfAUXWaI4VZV1qiW6CukxjKaR95k5r
         VETGgJosIOmLQRGxtnLSzMPnY2mI2Hdto6DRvZwl7+b/ftEQ4c+mnOoZZPM8UnN7TArd
         4a3wAd5MHWceHyFrVSVadVIm4mQXXBYYT7lHqKcQTB+/lC+Q9m4SfYESq5oPez/h0mBE
         svGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780962410; x=1781567210;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDhk7mb9732ct0z/PfRvTx05SqomPqvS5/mzVTKaoG4=;
        b=Sz7QN9Mgbj6h7oc2FLqhBcU20qQ2EKLaFB1/Fs8BvmNiSowFE+/hAwvEoqkIjauPuj
         Fl5RAPvXuw8pldcwxeqjW9ewZPZY4zTb82llc2tOoAuw1WqaSF7ks6e56564TJFiOIjg
         aCme55lY46CCuVk7qh+uWMQ98yTYDCGDDgKju+e6ri4VCOaU3lyOW4p9m8Ku6DQeAiZd
         nvTqCzHotDMz5WV7nsJSiTD/MLJE00ZH/HGmIUenjkBLd9vpY2xt+gN5FUiEDOCcTRC4
         UcaHF7QVXJLu2k/+aobyIzZVsxFj4+WvzxTW+EUpJXi6qcyqWns2wv+c8FXM9UYYj8eK
         5WKg==
X-Forwarded-Encrypted: i=1; AFNElJ+Qx/2ks04qPdCRGdzXqgtJ/7qGeFwcNITdwS0Dwx9o92BzjPawilOSHarp90FCBiC3ln3nsMeNi0PI+rjFOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGFxnkVqHJ4tLu6gVpnmCLtm3M66PMUkVzDfGX6tZDOiaXQcX
	hzDDehPsSfd1rREgsLAc+gCEPS6Guljab1WvpKt5unuwnVMx6qsSWQBgDh9K4ecl
X-Gm-Gg: Acq92OHAsAhe5pWRzq0x5MYpgUNDZNvwkDSTGWPFoozKLMMNMHcrnvQf7bz7GFvTRmS
	0IZ6vymDe5RAwbmRCazTqNyc0rm/5Q5uARiz22EV3eGYwmWDiGBWBBDcoSWnN446Whl8nczh1+E
	85IwQiGEcW7icP4WCyhb0RafHq3ALKRoc+9OC2okzpCXrUR0/yknBhNIRaXE4gABUbiA9MutFu6
	UY48rX0d3cVxfOc+lzIQLO1cT1gNo+CoNUIer80FMiGRPgD1hlVenOUVHchu49HDOHJxTYhO0md
	oNYrPkbi/9435bis4DK71qXq6ts7G3WBT7f0KrnSX55eZsgZh7msFe5+VbRhmxy8sEGOh3WDG04
	10l2DyAljaTZP6+GctlxZ4op26ilhsCLYvpCkqeiCfDmHVWbcr+qv0xIynqrEjd0/hWefzy3Gcl
	EOmyWlIqa0BgxFYjpLl4Sz98L19Ut3TT0l6YPFdmmfcU7NJtxlYE8/r+8hXsx/QtJ6eIHBgdc/A
	Oet+J8sJvmO/8hamlZ3Jfh/QJzRpOA0JBk9FW0o0uh63WZgTXM=
X-Received: by 2002:a53:d009:0:b0:65c:ca50:d7 with SMTP id 956f58d0204a3-66106f89b39mr14051413d50.49.1780962410424;
        Mon, 08 Jun 2026 16:46:50 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2358876csm88920197b3.24.2026.06.08.16.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 16:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 16:46:48 -0700
Message-Id: <DJ42HFIUK9CW.3KNNGNAFFJMCW@gmail.com>
Cc: "Wim Van Sebroeck" <wim@linux-watchdog.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] watchdog: pika_wdt: enable COMPILE_TEST builds
From: "Rosen Penev" <rosenp@gmail.com>
To: "Guenter Roeck" <linux@roeck-us.net>, "Rosen Penev" <rosenp@gmail.com>,
 <linux-watchdog@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260608210402.31545-1-rosenp@gmail.com>
 <20260608210402.31545-3-rosenp@gmail.com>
 <235a947c-b95c-4de6-8ca6-5656b5358149@roeck-us.net>
In-Reply-To: <235a947c-b95c-4de6-8ca6-5656b5358149@roeck-us.net>

On Mon Jun 8, 2026 at 3:55 PM PDT, Guenter Roeck wrote:
> On 6/8/26 14:04, Rosen Penev wrote:
>> Replace powerpc-specific I/O accessors (in_be32/out_be32) with
>> generic ones (ioread32be/iowrite32be) so the driver can be
>> compile-tested on other architectures.  Relax the Kconfig
>> dependency accordingly and add the required HAS_IOMEM.
>>
>> Assisted-by: opencode:big-pickle
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
>
> I really don't think this is worth the trouble just to be able
> to support COMPILE_TEST on all architectures. This is an old watchdog
> driver. It should not be touched except to fix bugs.
>
> Didn't I say that before ?
Sounds like this driver should be left alone then.
>
> Thanks,
> Guenter

