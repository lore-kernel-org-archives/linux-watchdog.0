Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264493;
	b=hb8iYI3j301cE2JpAYlWyhf90CLj7KVbBt4piU7tLAriV9N6Wfd8WwyRhh8ZexoVK6wZ
	 SK1XOpPS/gD+EFo2AMKavyRbiDNRDG/TkarRFI367xrFjN6aTE3q8yTtntQaLbfnI3Ou+
	 pRMSY7O/oEGSWyepA389YFT/7+Cae1jDiQaADAQgxbe/C9qTtUqyvpWPaECpXrdDRKBmZ
	 SbEsrvCfWk0XDFamJG54Mwf2SjOoVQK/wzedcrTtha2R87kDfoHYs1t/UEajIqG4lq2VI
	 MHDsZIUZzVqGNNn9tq89gWxVXQvwxF5NGUaHf+nsbl8Vwt2YsMSQk5Fbmyq3Rjcnhig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
	b=1LD8VAnTGtou50baVlMmPH53ir7jH3Z59/9D9Mpi8kuYDbScitWUvBQDxoepYzOwDm2o
	 C2OeUXTR6LjKP+9yV17WUpP2y89Ofa1syi+gqoaawmtNJlcUkCF9IZW17BkKeL+fDtawT
	 dqzPDqZ/HUel9Xm1VmsyzMHaFsXZokqR2mWFZKjWxc9bX0CUC2+ZKVnMNmFDDsB/fmENh
	 rLqC2VYcYng5BOiHlTCilH3bGD9V6glIEdvzADgc9qNNdIUiaCx2b4cZN9mCdShApfkGb
	 l5zDxekBXCIwArjFCaNnpehKhwBsjuXHQrNzuNbUwN6OYMX2cQnEssPlQ6zuGvF1RZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA3LCyJ7;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739B606A331
	for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0739B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CA3LCyJ7
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3465641eec.0
        for <linux-watchdog@vger.kernel.org>; Thu, 29 Oct 2026 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264492; x=1793869292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
        b=CA3LCyJ7nJ/xoJVBGK7euuvFzDooHoTkancn1/gOxLVhjkV9W0IXBNdBCqW/OiX92H
         9gXvxbQ5ViuabsM2dJqowCO25Nhn0OnwZtEr0DGEq1trREc/LmtGBEDHIE1+uJOjFOzK
         xc3mXgwxk1dwMn3lfUNHTlk1yX9y2ij0QeRu6KKP3rTNCIj2saYmL0zm0nbzBivHhcUk
         +MUT5NcNWQ+IQenZp4oOj7GXdjUVtpF16UUjZ9VbmIyylrrQjEGl+1U/aQKidV+fsDBe
         +5j+PrkMZuRgJ7aKoCIDWEYqX4gv0aePmwTjEVe1F0VQVTuVNSwHPI5oGlTatJ1SLARt
         DX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264492; x=1793869292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ZHPP80P/K5Og+av73zHRl2Ft2Q1yinNFTFs8Wj9Vvw=;
        b=CPNdJJFUDzsuzTjUjEUK5Rq89shNxwt0uyLd3IIw+gM1IEOcZxKAFZsR9ZpyfTsebV
         8Aor8kHHMopV0e0GRwqLVFiG7NfL4PoozihkQpD40pEJaCujtrOFadgx4WNFUw2B7oN5
         eOtVKdSfeo13fsXGvfZ/hU0r0onhthxI1JE26mf1ChOYB9tuFGZkjFdSIc1mu5/9WGie
         1+ETft8Z5QJVU7etg0m2eY1SP3ikUhBmTuBh/rYT2IXlKvgfFAyzOiQPOqJvdJu/2mUI
         yY1noqjEobuT9ED+z1DoA6ulCY513fE9lmQmkXJVX4PWhStB6vvG4nQJqeyfvyLenPlB
         IANg==
X-Forwarded-Encrypted: i=1; AKwUvBwLzFyjiwlX27Vnc9HpiPqeDoelzLw90xwsK4KrWm6/6PzgkHzFEyAYZmHvk69l9CMkz2ymgqLHIDtoHXmvgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJzosXpb6GPtKxFHb8/qdDnDjpQSJaO/oLs8/i7OGiWFx9UJ5DN
	YUp0mn93ULvNEIs0MK6KQwUSn4GjT/ac+OMQjQ/cGDBIqJEibvoFP/c=
X-Gm-Gg: AYBFou1zJBrrEiDmWtM6UEg7FOxgNEHtdEI55WOPuTsVLl0gGB/NQQGDhnj2PXO3Ofd
	Babq6bpq1rNQXH3cHrVAg7AnQLmJKPQiD992v3r7UpDYFNEo0RR4dLwTsgJAAwclwXFV4yOX0Er
	/Xq8TlfVoRUb6xdyhhFwks3DrvDp8y9rr8/0MuTXLspXA5X8q85lCei780mOFP0kfh1KjQfXaaz
	EpgijQr+5tLFusXhWhc57fyjmL0Hyi9wCaoNHY6NQxN2l0/BZu4CfJ5xYgYbEwJZwY2emAQY1qk
	CulMnOPKH22RJ9PgbgOk7I72gfGZe8ZtnQFPH4sg4SS01ZNojK7+uIDbzf4oO2kNLlZPAd8DyY6
	4yGzAXpKmfOzVmGGppXJqKnkwYf37D2buw8mE761XAWBUd54baRxGsbOmT9azAf3+lgnW0L++9q
	mhl7rgWRm6nSCG/644FSJ+lkxmiv7OLodRqCIJ9eTu3Uif+eF5cJa7IrJ7hSeDI/lPQmdEJEDa9
	SLSqIcG5ISq0xrhpNG4nhnvrnZ8eMvXh8TJQXfsL9Ot3MYw2SY8DTskGIVQ81UAUGCIfpFA0Ewj
	aXJ2V4TIdf634IUoggGtLzAaa39AjkEiauQgX7JYTGAT4+BoysajDMa02FdsgQ==
X-Received: by 2002:a05:7300:f587:b0:369:fc38:6821 with SMTP id 5a478bee46e88-36a20113296mr6116491eec.12.1793264491785;
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:01:31 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 12/14] hwmon/macsmc: add more types
Date: Thu, 29 Oct 2026 04:52:09 -0400
Message-ID: <20261029085504.3547-13-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMC keys come in many data types, and Intel Macs use a lot
that macsmc-hwmon couldn't read, such as the signed fixed
point types like sp1e.

Add support for the common integer and fixed point types,
and allow writing fan speeds.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/hwmon/macsmc-hwmon.c | 310 +++++++++++++++++++++++++++++++++++
 1 file changed, 310 insertions(+)

diff --git a/drivers/hwmon/macsmc-hwmon.c b/drivers/hwmon/macsmc-hwmon.c
index 1500ec2cc..2e74dcd66 100644
--- a/drivers/hwmon/macsmc-hwmon.c
+++ b/drivers/hwmon/macsmc-hwmon.c
@@ -221,6 +221,313 @@ static int macsmc_hwmon_read_key(struct apple_smc *smc,
 			*val = (long)ioft;
 		break;
 	}
+	/* unsigned 8-bit integer */
+	case __SMC_KEY('u', 'i', '8', ' '): {
+		u8 ui8 = 0;
+
+		ret = apple_smc_read_u8(smc, sensor->macsmc_key, &ui8);
+		if (ret)
+			return ret;
+
+		*val = ui8 * scale;
+		break;
+	}
+	/* signed 8-bit integer */
+	case __SMC_KEY('s', 'i', '8', ' '): {
+		s8 si8 = 0;
+
+		ret = apple_smc_read_s8(smc, sensor->macsmc_key, &si8);
+		if (ret)
+			return ret;
+
+		*val = si8 * scale;
+		break;
+	}
+	/* unsigned 16-bit integer */
+	case __SMC_KEY('u', 'i', '1', '6'): {
+		u16 ui16 = 0;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &ui16);
+		if (ret)
+			return ret;
+
+		*val = ui16 * scale;
+		break;
+	}
+	/* signed 16-bit integer */
+	case __SMC_KEY('s', 'i', '1', '6'): {
+		s16 si16 = 0;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &si16);
+		if (ret)
+			return ret;
+
+		*val = si16 * scale;
+		break;
+	}
+	/* unsigned 32-bit integer */
+	case __SMC_KEY('u', 'i', '3', '2'): {
+		u32 ui32 = 0;
+
+		ret = apple_smc_read_u32(smc, sensor->macsmc_key, &ui32);
+		if (ret)
+			return ret;
+
+		*val = ui32 * scale;
+		break;
+	}
+	/* signed 32-bit integer */
+	case __SMC_KEY('s', 'i', '3', '2'): {
+		s32 si32;
+
+		ret = apple_smc_read_s32(smc, sensor->macsmc_key, &si32);
+		if (ret)
+			return ret;
+
+		*val = si32 * scale;
+		break;
+	}
+	/* 2.14 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '2', 'e'): {
+		u16 fp2e;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp2e);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp2e), scale, BIT(14));
+		break;
+	}
+
+	/* 3.13 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '3', 'd'): {
+		u16 fp3d;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp3d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp3d), scale, BIT(13));
+		break;
+	}
+
+	/* 4.12 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '4', 'c'): {
+		u16 fp4c;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp4c);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp4c), scale, BIT(12));
+		break;
+	}
+
+	/* 5.11 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '5', 'b'): {
+		u16 fp5b;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp5b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp5b), scale, BIT(11));
+		break;
+	}
+
+	/* 6.10 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '6', 'a'): {
+		u16 fp6a;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp6a);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp6a), scale, BIT(10));
+		break;
+	}
+
+	/* 8.8 unsigned fixed point decimal */
+	case __SMC_KEY('f', 'p', '8', '8'): {
+		u16 fp88;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fp88);
+		if (ret)
+			return ret;
+
+		*val = mult_frac(be16_to_cpu(fp88), scale, BIT(8));
+		break;
+	}
+	/* 14.2 fixed point decimal */
+	case __SMC_KEY('f', 'p', 'e', '2'): {
+		/*
+		 * fpe2 is only used for fan stats and fan control
+		 * so precision is not needed
+		 */
+		u16 fpe2;
+
+		ret = apple_smc_read_u16(smc, sensor->macsmc_key, &fpe2);
+		if (ret)
+			return ret;
+
+		*val = (be16_to_cpu(fpe2) >> 2);
+		break;
+	}
+	/* 1.14 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '1', 'e'): {
+		s16 sp1e;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp1e);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp1e), scale, BIT(14));
+		break;
+	}
+
+	/* 2.13 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '2', 'd'): {
+		s16 sp2d;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp2d);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp2d), scale, BIT(13));
+		break;
+	}
+
+	/* 3.12 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '3', 'c'): {
+		s16 sp3c;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp3c);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp3c), scale, BIT(12));
+		break;
+	}
+
+	/* 4.11 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '4', 'b'): {
+		s16 sp4b;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp4b);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp4b), scale, BIT(11));
+		break;
+	}
+
+	/* 5.10 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '5', 'a'): {
+		s16 sp5a;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp5a);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp5a), scale, BIT(10));
+		break;
+	}
+
+	/* 6.9 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '6', '9'): {
+		s16 sp69;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp69);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp69), scale, BIT(9));
+		break;
+	}
+
+	/* 7.8 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '7', '8'): {
+		s16 sp78;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp78);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp78), scale, BIT(8));
+		break;
+	}
+
+	/* 8.7 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '8', '7'): {
+		s16 sp87;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp87);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp87), scale, BIT(7));
+		break;
+	}
+
+	/* 9.6 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', '9', '6'): {
+		s16 sp96;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &sp96);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(sp96), scale, BIT(6));
+		break;
+	}
+
+	/* 10.5 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'a', '5'): {
+		s16 spa5;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spa5);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spa5), scale, BIT(5));
+		break;
+	}
+
+	/* 12.3 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'c', '3'): {
+		s16 spc3;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spc3);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spc3), scale, BIT(3));
+		break;
+	}
+
+	/* 13.2 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'd', '2'): {
+		s16 spd2;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spd2);
+		if (ret)
+			return ret;
+
+		*val = mult_frac((s16)be16_to_cpu(spd2), scale, BIT(2));
+		break;
+	}
+
+	/* 15.0 signed fixed point decimal */
+	case __SMC_KEY('s', 'p', 'f', '0'): {
+		s16 spf0;
+
+		ret = apple_smc_read_s16(smc, sensor->macsmc_key, &spf0);
+		if (ret)
+			return ret;
+
+		*val = (s16)be16_to_cpu(spf0) * scale;
+		break;
+	}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -263,6 +570,9 @@ static int macsmc_hwmon_write_key(struct apple_smc *smc,
 	/* unsigned 8-bit integer */
 	case __SMC_KEY('u', 'i', '8', ' '):
 		return apple_smc_write_u8(smc, sensor->macsmc_key, val);
+	/* 14.2 fixed point decimal */
+	case __SMC_KEY('f', 'p', 'e', '2'):
+		return apple_smc_write_u16(smc, sensor->macsmc_key, cpu_to_be16(val << 2));
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.55.0

