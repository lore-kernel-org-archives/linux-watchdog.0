Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460908;
	b=TxbIqz/iCuWbvBAc09YBNoqiQpJ5t2Dw8vvqYIzDYkqhPs7ng42YDc95rx8H1kH7KZRH
	 Wy26yUXTzn/t5xEN45fq0Iw21D3ncR1SgxjurIQBNDzOvDrfJr83UnMkwctVYxmZvuA1e
	 7jSWJEN+Df40Yk+4bmNj3O4yDu20h7GG/YCNs/YJWfNfeQFbKvaqc3n/UGKKWrDVFIUrz
	 l0fygNxHPhTYYHgls0kjuMKMNZMc4t8/wDRGbXVPacxfmq9waM97aeP6wy13FK+aEUQC5
	 66xXg4KEWGl3FfOssjodcVE/8z/+bvto7/YapxRmQO3yFJRDY+Tkb+FE2e19tN9Hi6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ezGP1Yonno3ZtROnLi8FLhe0PdCDx+ACf/Q9hTx5uuM=;
	b=NjZpLbwWs7TA3TFW69UW9osGjKZ0yekiHS+htWNNABwfMw0i9EQ9qSz8zue8qDYIlEj6
	 1oyx7AaWjNB0nJnBlqCFksEGCTn7JX7w6N9c73ViTto6MvM9lYtzru4vbORJ311JE+nE4
	 UmcURJmqnJZHB9CTHPz7eCP5E76XxVj4PCDt77hTvjIcmyb3UCi9NMax9SxiWK4Ml/+JH
	 QrpEjkaYB3md6oh79cw/UxSjKgWOxcYR0CUSSsvgZfA5cD7cfQ+1tTpLQpwEzp/akosiW
	 oDXIOF7RGBADJmeHCmRouj7owemJn/MsmZE6DWtVQpQi8ECr14rClaKqZybtcabWjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FZkWFoVY;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B4606A31B
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED7B4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FZkWFoVY
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4957833eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460907; x=1793065707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ezGP1Yonno3ZtROnLi8FLhe0PdCDx+ACf/Q9hTx5uuM=;
        b=FZkWFoVYsMtjoo4moW2w7KngMWoj4ckM6+YHFDl/bGjZ/ieFwRpf8QXxMADqaL6jCf
         oZ2vFEJ6GWTQ0h0587RDMCGKndR1Sv5wCTQAsh+TEFJUHA+uQ9nhoN+n65iGv2wXnpVm
         zGpR1cJ1E6C1gtBxo0zeZHgULiQ0Jy2kmGA9zYIAe81Jp+aYLLToZQ8iLbGkziFwAM5K
         sMYXKWct0/DIwBcna//boojaxbfdQiBnDmiXu711WywsAgWJuup9m11wjE2izpvRxbC/
         ZgP6PtE6mixlMmzm/BClDggHYm4pxnNogIdIQoTrzwoqpXn7rKS6opG0v1Rimc8cEaDN
         6NEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460907; x=1793065707;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezGP1Yonno3ZtROnLi8FLhe0PdCDx+ACf/Q9hTx5uuM=;
        b=W+c8jQ1KOGNMi05gLanDQ3W5AAQ6OUh7H+5lub1plP4XB9uGYkbqvkMqAnzXbxYDO5
         ROrJJ8U/IjmUynGBT0vJ0ZBlAFhMcNTTNDkbgBqPojGw8nizzo9KP5ts2PuN5qrwrML0
         YCYhhLpA7R2gwyHefjkMpDSDLIdtrze/uU3XvNj0L6lycxPAdYBZPobGIpTZp1/zFfDo
         uo0M7LnfCuSS4JarGZM/D9k8eSNe6LVgdbwU4fy/S7sfluNJC5grEdrFOa8Pn9jFqSEX
         Bu42e1oUqh4YV/+kCnHIJ8l21YeC6QYhqrzLUbuZmjxNT5IrTAfbtHIczMv2yxeRIBaN
         7PDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCPvFUW9PfFVz38H+KV5KsVqfYB7+NyxvU/ZrHwzr7vnZD19zrFtFkhM4cuypb8EAZtGa40OL+OzxfqVqGEA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8Yv3Cs98gQQF2jSdpuWtauddwqiMsmKus5vgg/yK/mi57Hxzv
	OWqvkfXTVMshNmctqasjCKFn1Hk5+96OYO4VLkC+dFI5uv0hU8o6U+/S
X-Gm-Gg: AYBFou1VRsTR3BYVMaA0UT8ChJkTXSJCQ65iqkbwS7rXQWpK3T9ff42pfhnHJYpOOpt
	No80/ukvWh32EdvUdRBJuPF+W8mJOQ961urAxlRBBmkgSNibQwAoM/Ghz9YiqA3/pKp6Rr4bG2n
	hf1xHUZep0Kxya8o92PsC7gkW4Xx6ur+7CVidxsqCLH2Q6OiRLTRS+0jq9yV5dB0pa5t4r2Fyow
	tjwVeuYt200t1h80XdTNPK0LExaXYZtIA+IJOeE/buDg0xjsCjr9Cr4HhJ0N+od3C/BO+g1cPwo
	5IMwH51pE52p0wQ/d0zZI2o51OcnwDd2+tAgQ0p9x00ROefR9M172l3T0DLBOkr4gipR0V9nVGD
	+peDi+uuZ1fPil1tudRn8zbHo6vQuGdKFjyVw0vTPuqzIzjIHsPc6xO5n0FP8ug04UnKKzARpGi
	xI7/THrO3z+X1VtO9IkvWl8mKLnIJUTjFj4kY/QDNwco07eUTLLmTuRPxSrRN8gkH/VwYRRpZ5p
	VldvXZ1mWOZ
X-Received: by 2002:a05:7023:c087:b0:156:3684:96d4 with SMTP id a92af1059eb24-1851238b5e7mr13733617c88.25.1792460907214;
        Mon, 19 Oct 2026 18:48:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm28699903c88.14.2026.10.19.18.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:48:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:48:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: mediatek: add MT7629 reset controller
 support
Message-ID: <4606c758-16ca-4fca-9a0c-babf15643b49@roeck-us.net>
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
 <20260926-b4-mt7629-toprgu-v1-2-c124bf9ac273@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-b4-mt7629-toprgu-v1-2-c124bf9ac273@gmail.com>

On Sat, Sep 26, 2026 at 07:14:00PM +0800, Chuanhong Guo wrote:
> MT7629 currently matches the MT6589 fallback, which exposes reset IDs
> 0 through 11. The MT7629 CONN_MCU reset is at bit 12 of the SWSYSRST
> register and cannot be requested through this fallback.
> 
> Add MT7629 match data with 13 reset IDs to cover the CONN_MCU reset.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>

Applied.

Thanks,
Guenter
