Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917484;
	b=pY44LNs49WwyCu0yYLezCMksQp3nbZc5Ua/B3fAzyB10Euabyc9j+KB+AgnJtrVCzo5i
	 FZK+ShR4+l9CLr4zOEftMZ6kxcXBf/GgGUSa5ttmI7xUdbkaBVL+CyQRgv5Ct+K/yULHq
	 +8rwsQ11YQdW0fzEvJ6LbeLyIxPRRNSUXH7mk11dVX2V7Gg/ai/Z4hoJHIGvUL16Ct+vM
	 E3p/gQ2JLf+qdE9GFin9Hg62llNrK2U47uUjNHFnR7Nu0k57GnLeCXyxqwxTwNgo5JXdG
	 lWWW0QlIiQZ2OGlsaMJAxDP0sfBChatmDOBIPMKxIeDqh6bLAWTFTuV2rg1kzGlNa5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z9XTrE2yrR3HPAGKN8cfazsOZArS5Wy1dlBvlHzw8y0=;
	b=Zi/WElK1LLl/2csukrWgLgy46KhGw4Udyej8PdvokoFSmF0ivO3lfoqVCK+85i5P8sOf
	 0O0sTcMKdAHDuY3e0AoQJVT7ubTdWb0u+T9uXyb50LXPPthWKD8wIaPvfTArmDcqeN38y
	 tWNNzwZRp/EllsMswa7lvZF3vJgLPKZjA/6jPqkVS+JtLHo9ERHZyQEQ3VgHj4sOQgQF+
	 8QhQAGWTmbXYN/LA2eLR74aqFS4fcgBNrEG5TVctDt6Ks5U+G/8tpbUDwPLwjpbFl2xiH
	 EPS4AQcOoGYc0IoOkMu2sVFkGSi+UGMGXtgFGXGRxgdbzQSYBwkXd/so+Lm/ibpDIGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnGWqdjO;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056A606A31B
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 22:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5056A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GnGWqdjO
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so431063a12.1
        for <linux-watchdog@vger.kernel.org>; Thu, 05 Nov 2026 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793917483; x=1794522283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9XTrE2yrR3HPAGKN8cfazsOZArS5Wy1dlBvlHzw8y0=;
        b=GnGWqdjOEcjf/+4W8F+F9FVjds3+v932m9PLoYSn38RfJhSVzDzxwCGKWm04TwwmY6
         VxL5eFs9njfpPRpQrH0Y6uCv5kXKpTPOWuNwZk7N+Yr+MMvOnPFCCmv9qskltSEdnJ7q
         geBsjgL0myKHYhfZrQFSev+kBK7WaEBjO64OtPz2GnEun/eIdhSMVeDKOrF/XTFXgKTK
         b7yALxR+N/CVuzhw2sHyro3oh7HpJwXH48xJDWMrLi7LLJ6EDhSy0Xb00kjqM+PJ/fXo
         in6YoOuerlF62CFYLxYfNdcZhs+YnfdJfKBNhqmA6YvGL1WJvucqNPpXQEjArCIoP49u
         Li7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793917483; x=1794522283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9XTrE2yrR3HPAGKN8cfazsOZArS5Wy1dlBvlHzw8y0=;
        b=aprtML+uz1kABVKOnU/OXUCNv4WMtNl6v5BdNYWk1hWg4r59fVdJYlGCtGfJI3oQCl
         Ot/YM1chsNTxi7T/62JHmOr1/XLG4Vjdfv5k+d+9dVPSjDqi/6un9x7fBAyWBpE0WYnN
         wlYvFY80Pqp11aGzXXEwerXjSTHjvTUUGQKrgVGW6fcJJPXU2GFw1iTpec8hwJByzu/t
         dcGyEGRDHfRJcridbJ7S/O+qk/Ax+YXA0e9anVf9WbNQZhSodBDaEree8iXB5ZbHIoLX
         ItZ35dTOA0F2nL0W7WiKdQYDs6Mk3R0z9x6/t/Msvxr4pMGo8nvI5ySo5DCskgGoO5jC
         XnwA==
X-Forwarded-Encrypted: i=1; AKwUvByXvwk4jEyZnNtk0y0WkCt83WMchyfYy+cCtmZMhTLozd60sxzg1qLJss0gOjvF3PwdfjKAnG0LnZRz930elg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/D22Q8bbU4Ph1c09zowHb3sprS94n6+EW5b6slST0ZxrClvtLI
	qfzIoc5oEkXOdfwwUT9fjuHsa7cZj26NcDj/2o6TiO1Z50YLW8n86hI5
X-Gm-Gg: AYBFou1LETzD8f/be3rrzQ6a8TO88IPwU/uoIA/ZfCIRdYBuHHGa6qQ2sl/k4tvR2nW
	tgxo3IGMAcxnDwcq6ftOAnYJzOInDO4lnGXj6ARdq7YzUNtN2g84fyVReMHvT9RePuq8CJ1HoEp
	jNUq46WlzlgmO4j1xRgyrgMXFq0evdulw8a+XZPCUipfE0tLQ+um0A2dFdZNzh4cOwhD6EgjcxZ
	4bz+PrpDQXDrSQZY+wy6LaDC6vkvP43YrHoUWS00tx3rIJdn1Oc0HW/wABq6TMHKLwuXNBIJaeE
	YCKw9fXjL5DdJ4u3K4B0/SZHKw4Q3P1AvwRtjzmBBgT7yj8tSdE+usKJsERKolPF9iKe6t7nOjp
	2tv1OxyuOHYxpCTgUEox5bgLoEfIYhEX2qTY6hvPGOyQemtv7ipN8XwzevfL6gsJef1FdB1X6th
	OiW/IuaMXYfzSLfYeKG8CSc06B8rYYTAOZOZPrPSzBGRPMHmddRO+lnQO3hTOsZiBt40G3To74Y
	JwgBidfnmZhDq1K0QIIDHN94O+v8QHXR/ky6O8nwF/6rtpyaMyALA9hm8kIkAafX97FRYsInP33
	cKDT1fD511kdsyw4omM6+XY5lBuWbXF0StttLEA0F4MeWHuCLA==
X-Received: by 2002:a05:6402:5384:b0:6b4:d7fb:affd with SMTP id 4fb4d7f45d1cf-6b5977de20emr411756a12.12.1793917482391;
        Thu, 05 Nov 2026 14:24:42 -0800 (PST)
Received: from letov ([62.41.24.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac57b9csm2103697a12.15.2026.11.05.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:24:41 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Alexander Letuchiy <asalde.le1@gmail.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6895
Date: Fri,  6 Nov 2026 01:24:34 +0300
Message-ID: <20261105222435.571449-1-asalde.le1@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xUMh3NwVp4cBhFsWWFE2Xng4h8YH95iJM37_I158WAyVmsRCPbirWT1iU8eMFeiSFw8xco0X45o-2NOeB6Jc4_nWAg25pFPgDMwK3mKzm34=@protonmail.com>
References: <xUMh3NwVp4cBhFsWWFE2Xng4h8YH95iJM37_I158WAyVmsRCPbirWT1iU8eMFeiSFw8xco0X45o-2NOeB6Jc4_nWAg25pFPgDMwK3mKzm34=@protonmail.com>
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

Hi Roman,

Thanks for looking.

On Thu, Nov 5, 2026 at 11:50 PM, Roman Vivchar wrote:
> Does mt6895 actually share the same reset layout as mt6589? Given the
> generation leap between these, the former is very unlikely to use
> the same resets.

The vendor kernel for this SoC binds the watchdog with the same
compatible list ("mediatek,mt6895-wdt", "mediatek,mt6589-wdt") at the
same address, and its register definitions are identical to mtk_wdt.c.

The TOPRGU reset layout is the one thing I can't confirm, as I found no
reset table for MT6895 there. This series does not use it: the DT has
no #reset-cells and no consumers. If reset lines are needed later, I
will add a dedicated mt6895_data to the driver.

I also tested the watchdog on the device: while userspace keeps
kicking it, the system stays up, and once the kicks stop the watchdog
resets the board after the timeout.

Best regards,
Alexander
