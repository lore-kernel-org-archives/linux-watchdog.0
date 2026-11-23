Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476530;
	b=gHlifaiDcV1FuQ2119crFm0J+hoD5OqVV2Sg5BXf9LrD82FT66MQPerlU1+3ekwN/hPn
	 PI8L/GTb5+UWgHNP6QPIYCy4Du96F5htAsyCM7WEKHt6ZJkLvGeu2qKlcxCdNqYyk4ZK3
	 FFYenvKnd6GBBVCpZsv1P8a4LjXWfpm/vJBrli7oKAJZ86fh9WX/PFbGgYD2qn0mCH06K
	 HC8IGZllIYlrQS5bwMq7iUL+eWwIRkGpqFNZiUr8BmJsh9sh+E3mLCGJizzOE4MTi2Ulm
	 GARyQ7Gu872Wr0GQFQL5tjVnEDleD+XBsv/Ba6mIbIP2sWI5UweA0DnRuEMBPq3mQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FwJrm1ZM1aehEhc2izkgjrLKRPEQAGiya3xImxW3kxg=;
	b=aUZ8CF2U8+lhWLppabqH1oDKhS4gOefrLB+y6T3ieh5Hof9n8dpL1NWapOB7j5rJY7JM
	 9mQ1ro1bNX58B/kvM5J5UgVIEuKnHYDdJUNfJNQgqGgZc4ncKAnrang0mKedTFeBKGwrH
	 IrWbJFBB41z9gFjQqZZL3kOFENWcrcolPGlfFBGkqVOf7t00s9NM/AIGzNurg0PAQXkNx
	 L7xxsV7j3tVAK7mLdDDLBvGZgu4xzJvqrqwwfMZ3tA3Fg4TKT0+IGgtJTxiOSPJXQv6pE
	 GvQ4uyuKkpotXyKx/wgAO7KLVR2ZcP6DFJ8eJpZJWf5XfLcm/0GrnWZcXp2OZBPbWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nAJlelzV;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCD606A332
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 23:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DCD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nAJlelzV
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so4579629a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795476528; x=1796081328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FwJrm1ZM1aehEhc2izkgjrLKRPEQAGiya3xImxW3kxg=;
        b=nAJlelzV0W3bFHx1nGZMeGZf3y/OlXVcMa/J8vDvS2w6VWGcot66X8UINPIPB8tBuQ
         GmQjfzIWAwjz8+VDCIPqbsgcos9UcuSo7As81vg5OTC2Xxbhemto71gX3I13isNm6KVw
         ueG/2Geai9otTFoOviDwOK+kaj6BliZMYsp7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476528; x=1796081328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FwJrm1ZM1aehEhc2izkgjrLKRPEQAGiya3xImxW3kxg=;
        b=DTMe4YhWZIz+LRhMp6xC4yuL5lKRP8jIuuYNitmgOHX5jvCWrbNgF7c7FodtmilO9G
         isikTkMIU5+Ki7Hs2H3H8DbJK1PcsfldrV4nFxCoepNLmdof07m9StUgsgzFviBgO24b
         k+lxowLemv7YCeRtD/w65tz8OLSriHU4DuKzTgnj6U1KjdEdZO/HEkKYlhRzZ85ouv50
         u8nRlOXac0vCvXA4nQ2WTrC/0e66L2/mtAkztOqgHOpMH8T3eLMTNm4Q7CTsLhQRUZy5
         tJT3U7AtOniWPR128XnQSkwhPbB7Ob2uESJXYyWdU50s9P5SrZ3XhyFCq/cANQHZY/AJ
         XwjQ==
X-Forwarded-Encrypted: i=1; AL+hErFhRd4eYPARkmRq0N9ndRWx00hhnZqj2Z9BYaClYIwYgskTP7vc8eNKOeZue3uH5uQ/Uy9+nBWXVmy468bxfQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+LX4wBKhNFkqUWFBAb1LQTktoIk+PhkpkDN3SqEYJLz1+muIo3
	pOkQo88LfVEoF23Bo7QRaGP4c7FXRXwQkQ7qdxIAcgTKQkq9+xGbcwbYk6jVH9NpE1zc3gT1kcK
	jkvP7o4/V
X-Gm-Gg: AZFdTZfuj4uxkmBRLVkfDGGL0zEY8eD5uIfNC0yEhXmIVMuhUu5cAWWVDpBKRQyssOS
	yg/gHCdQQk6DjIR/RqdlXj+vdLG0KCiQVJBao0eMh3MtN/CSPFsowFo9SxiuGAjaDT10V54MFaX
	UI2p8MZvmH5n5RFJMNLbTJkDdPdDTVodaWc46RNsFxrkG1lmQUUeddtck7UHP/41AupgNc0kkwn
	UqCalmLuUuRTmXWx5aWEjUVF0ykVafom8C0K4d2Syz+hI2V/Eo5lTp5UC+b0HZblcBdgKQSzN+J
	2i/rgGfMjmBqRtG/U17pKCgz2WDyuiBaSDejkkDI+t2g8JN5zoKCuhe704owqOFLtM12Qsrh+Fr
	onM5m8QQiBxjorSFZHXANjbSivjlPfb1zlNXkF4kyRGmz5VgLs2pPyuuiaRXfxex7H5kPU0TbQs
	MHD58RYJc0KWte9vteEVaZP1m8PhVNhFheVFkxxoS7PWb27bh8FXIuNbN2utItnPBxdulALD6RA
	gAPVR09hS++QFUiUBOcS4tyIn6YTm3ov337TB/cr2nDyWASAF60yVm9TcO4XVdjMROMuGvTuSTP
	wSylJNl7FgnuxqP8bQf+PHPsUZlDAG+Ma+QdjpnwgxtWZK4NIx9pH8zzzdljkAVE1tHKLQ==
X-Received: by 2002:a05:6402:501c:b0:6b8:afbd:64e6 with SMTP id 4fb4d7f45d1cf-6ba37edaf1cmr9347582a12.42.1795476528509;
        Mon, 23 Nov 2026 15:28:48 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm4093169a12.36.2026.11.23.15.28.45
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:28:45 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so2777545f8f.3
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 15:28:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHu3VbNOeW6PBP8l8IrVgygoQmGeyAHS61BFcDlti2XkMt0Ceml3DP9OJI5j/SSmaaDLwWvqTeoc0gap8QCRw==@vger.kernel.org
X-Received: by 2002:a05:6000:26ca:b0:4a7:8406:1e6f with SMTP id
 ffacd0b85a97d-4abb0c5d691mr23431674f8f.17.1795476524227; Mon, 23 Nov 2026
 15:28:44 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com> <20261112031629.396819-4-mrungta@google.com>
In-Reply-To: <20261112031629.396819-4-mrungta@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 23 Nov 2026 15:28:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WosKh8Rxh1J1cJDaWOEfS-pYneBmjd8FzOV3oyv0HgdQ@mail.gmail.com>
X-Gm-Features: Aa3M54rF-cDwPhWxLgyNjBG3mfbaET9nDbSRqTDaBh2OJu2DLtMaENnnVT7qQnE
Message-ID: <CAD=FV=WosKh8Rxh1J1cJDaWOEfS-pYneBmjd8FzOV3oyv0HgdQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] genirq: Implement synchronous disable_nmi()
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
> Currently, disable_nmi_nosync() is the only interface to disable an NMI
> line. Drivers stopping their devices need a synchronous variant that
> guarantees any running instance of the NMI handler has completed on other
> CPUs before returning.
>
> Implement disable_nmi() by validating the descriptor, disabling the line
> via __disable_irq_nosync(), and synchronizing in-flight NMI handlers via
> __synchronize_nmi().
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  include/linux/interrupt.h |  1 +
>  kernel/irq/manage.c       | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
