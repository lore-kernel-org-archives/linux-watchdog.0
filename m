Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419DE2931F0
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607393; cv=none; b=jt7gT3F1LLtC5JRoPfbEsNvdduUTOTWflzCGW0gqgf7UWZiQNNDQgqos0fkCwzYi1E1Y2PRa/hXsdFfqPXwIA6F+x5Bx4J5rQRyuVVacZCndclYpTMlQ3wvhiFQ+rNbnoDZ8ALzrRbvp4O7z5o7RHvpsTAqLL0TkTRPCcSwqKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607393; c=relaxed/simple;
	bh=wW0DhjjxvZrBOHLiq93URvUQIpbh5rFvMHFa6dq5YkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNd4x2K4OJV++1LZ2BVeIC3sdm6Vd2GhUNVRlnp5AlUDq7/X0+Frl0sae188d338aWyVf6bHj8Dq/I0lzGS+Kzf12ddgGfVrVo1bxMS5trxnapaZZxuVnj4/YR2XMKvxh1IBIS46ApWVl00t0fc83pL49d4Oas9rtDgvlQCPrxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YazLXU7H; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YazLXU7H"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso210933a12.0
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789607391; x=1790212191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nonWuzicTCeYBkiKvjrnS+sct50ruoIlfuFduwj3gS8=;
        b=YazLXU7HdPJVy8mhtNM95ZvSFubBlE1qHgbcS5h06wF/jF/smujnYMw+FqYDZdG8Lf
         5krFtNTHY8YsWsbe17qqIP0dblGNxn5R7LhqubF3g+yCZZLiyYDMDsak+ElKBNOFP4RU
         VFqGISEVhnZYPmTuBEMhz7AZe5gCf2/golhZnc/d6g+i1q0PhW5cgnA22a0/FVQlmFJ9
         H6TR7QYAosxlpPyV9qA5PCFqwD+tUqC6yV+vw9LYacrwEu6SdKNSYBU1+xPka9d8IxYL
         /IGpRWT5+e3G0RmVku+HbiSv+H+PCxnZZthjp5mlCyXD+RhdPENjttPFquI6/gbmnKvq
         uiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607391; x=1790212191;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nonWuzicTCeYBkiKvjrnS+sct50ruoIlfuFduwj3gS8=;
        b=gNBcwtjcqKi8SR28h/a7tqq4y1Mc5BtnrxUKFPCusuzMNvPxfMOCDED8cyGW8sJZdi
         8bCu0V/xO+vZCotmLDaSiDDWp4PSWqK+bS2G/9O6iMC4AjwofhilKn34K3GZCWEntADC
         yL1/5/0vGFGUHURc9d7Zj4/T2/RoPV9AE9WP9w/qUzk47Mq2UqSTeq3qjzdKimF3JmU8
         B6BvtWU6Kne4Np4iGZW6ys/M9kCx0qVnM82WhA7oauAqxH6ULuCDQhbnJ5JRVBbWHXao
         aIlhJrETzhmXFu2AYyCftbVhfnYjUIm0sh9CZMzaINVN3yANJSw8dCiJ9BE88ysLEUS2
         UCiA==
X-Forwarded-Encrypted: i=1; AKwUvBy05KkfhtecwD5n86bLkCPZu5pahobgIb/JRlFU6X3G98QuCP0fbJgXnH+JtGnURpfM6YdUwtPgiV0uwwSANA==@vger.kernel.org
X-Gm-Message-State: AFuF++llHJPJOWkFPm3nKQWzxK5FpBvEg85anthXBcSKVBOMmGGk+0J8
	Pu/vDvGg6CxspR4yTz4kQi1B9tK+z6jCF3mVrB8oSWyRY5fNXeL3HVPk
X-Gm-Gg: AYBFou2SX8WUbYyD09P0V2nLDc3OAxsLbF1vBBcltiNb8gvIhhsQmFFzNuwwk1hBL4q
	ZhwDrCPcyIeoYwoF2yJzxbv0JE1g1Kwc4TVOfPeKIhlJ27snFpRryMVb3xQOSvnMzVek7dWBSPf
	LtEwOqIeUhazyKd1w3uRalzS5N77Pu3Wyd3phaARbRGVThsSs1sWksN5wTZXGQ+yiYHGHIMnoh4
	3cTYjV0bGZSgL0//I9YfNgU2Mk66/8/VGDbk7tG9mu+fkwpbOoR4KCOxVL27dZbD0clBZ6r6FUZ
	Uxs8KBuv7aUZGq7gUOHPi9aGg07ygmTN5rqgRf1s4a5MO0Dyo+8DmuvxYOO5NvJ1rB08pd0bY0N
	ujxg5uXhUrO0AlBbHmLWUXBnocnbRlc3bfn0hotqJg/aBGxw8c6eyKczZkc8kibKa4b5U4uU91i
	330Jgz10mXRAjbxsQ3Df1ab2ZlViuYsalQtctDDArAEAlAtuR7LXtRKEUrWfdpS1xTabiS+gVDv
	qyQ1pQZwgEK
X-Received: by 2002:a17:90b:2c88:b0:39e:26a7:7aca with SMTP id 98e67ed59e1d1-39e26a77cefmr11932602a91.23.1789607391606;
        Wed, 16 Sep 2026 18:09:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cfb0b1sm8545272c88.5.2026.09.16.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 18:09:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 18:09:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/8] dt-bindings: watchdog: Add compatible for
 MediaTek mt8167
Message-ID: <f0ceff89-4fdc-4d93-8e0a-26137e1f4279@roeck-us.net>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-4-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908174259.9009-4-l.scorcia@gmail.com>

On Tue, Sep 08, 2026 at 07:38:30PM +0200, Luca Leonardo Scorcia wrote:
> Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
> which in turn falls back on mt6589-wdt. However according to the data
> sheet mt8167 toprgu is not actually compatible with mt6589 (it has 14 sw
> resets instead of 12, and its reset bit map table is different from
> mt6589).
> 
> Update the mtk-wdt binding to add a dedicated compatible for mt8167 and
> add the IDs that can be used in device trees to identify subsystem resets.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
