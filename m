Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=fYxXGqDwdshBnhgNX6pe993dSUIqrzqEJDU+lTQ8D3aYBNskThyunRAwXaItUbA9dpvw
	 JKwrwQB3WMsg8y+DTQEHioLpDEFU0n9lgkroMJsLdtMinfkRkXpOzxvEjdmQa+UUHHrw8
	 9ySzzsW6EmuO3ob1ueEMpeHHe429b09Pe94NUt6O45zEGQ34uk/9uL5qcCMfJqMkyJHbg
	 E4NgqJqf7ZZKJBe5k0KHeh1l1iQ3oEfY1Oe9P/bTpYPg7qI9LAvgKXs+8lfYvKFe0MsqG
	 cNnOHciJQ1XouzQCEK9g0brNtN7f9O1hdGU5EUYzAeBymXsdjYiQSa7O7yrvV9Ryr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=JTbiHOR+wtX+Zez3zzWcuBWdzs00CNDdLu1F+EshFKlstPBhyA8wmwzUJV+5UgwN5acI
	 x818zdpkgH+clyVGH5r1xkk4QEeEL9JVLVcDLf452hEujw5EyLK46jNOl7WFzIKIYu2Nx
	 AAq+l61MVs2hxDS/8o23jDJSjjPn8jg1oH+cFXexOG/X9OXG2FXz8jlLKVYGoaM6qcE0B
	 swnaOGOjsB5JO9Ksw0VHe3jLC83O0qfJeyMLeaTq/bCrgxsqOaRoGvm6ASUbXpnozjr0/
	 p35KWeTVZk9WV/qmwWoi3UM9aV2Kz6amUFCICvxU1Imi95LG3zmdX8Jv3d6kjQssi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E606083378
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E606083378
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1adbf62dd31so1554471c88.0
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=iAb76PZdYv29QQfZI81jjrbyp6hzA6KDpiNMTKZ09GX7XorD4NIuyyvl/XVaBQ7K4F
         gQTavxFHpXBFiUT9y2mAn+7HTaLj+GX9a3y9gTIrq1OUy/4rT/WhmTTtr2o/sTAHxwdR
         wd5ynAePu1h0oXG+6M28lVkt4l6z2KaCyOMzVbiUTgv3Q/B5ResuYAA10ePHhJQ0sMWZ
         zlWgRgwaCUDi/x6q7k0zCHZAVK9AMwWJpqI5d71jRPMzx/l/ar6IPzxkl4hDso6QWPD7
         +R9tifYuvr5vHbYL7Dh/a1G7rfW86JIDY8kp7t8k6RUnONJ69jmKzWUl9jeuF/vaTJm5
         jROQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8no9kDeLY4iHUmbnqd3YEAJnCxwY9XKiNbTBz+qWk5ax0cv9hoVrAsZ4d1J/p1SwY+n6OfyoWx9/wJN4VlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z92zSu9i3aFp7OUoPtAf+D1LnLgJBuzq7P0pKLuq5SqEfbHbUvT
	x3EM5kpSkz7IhnxANl1kn6O5wYjC5xZTraaxCi5/CKAAfGZRhoFp9Tk=
X-Gm-Gg: AYBFou19kum07g8obT9GoX/wVYK/dgrm0cJIrDZ5Z63SLwKAFn0P5v3o9fzwYJzmIIF
	JSuNezf8IgE8Hkt1kIjDuN16xUeNvrS/rVDr1ndA4wFhbEgW5HyMpdNfXV0kKD9RXJQEoxTZ6vY
	+j1BhhDDMTEnStyF68s3bYQmQ3pFBBzPt1IGVDqZqpl3TkFYW4DKgLDUEuSho9eyneeY5WBhzRO
	3tz1+ad4KumkSf4FPJ5VkQBFjUUK5uOyAxBNHVQa1MmsXNCDLde7CSjeYBn9dHaEmxjqAVEGsvO
	6oUgHEtisfFYqnS/sTBWIaVl4T+ZYkZjZJCVKG+U9bDy26PaELTW7Oi21f2CkqdLJW062qpDxOh
	JKG2Bg6utrUjNytbxWWzlr242QG+eROpcTVocfy68kVBGKWEYWVpgkd0jMVBA3rMD/JSev1/Dqp
	O50cDiO9EBJUan0p0AzD3Fs/bTAMQivCzRKEd5b3ETQbMyNWl8haBLh1M+H2TSgL7kq8QwvL2e2
	e73v+ZdcIk0QDS/dYu0Z5U3KpOoMbbgxxCNlgbSrHl3stO6aP1NQ3aFCFaB+45xqrrRxGMwo+hS
	glPSEvi/nf4JtrdsAgY6mPhDIjMo70QarLJ+dhqbqj2u57A2950WURy/VA5OUSf9IA==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
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

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
