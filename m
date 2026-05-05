Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29B3DE432;
	Tue,  5 May 2026 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966361; cv=none; b=gTju2qo/wECgLl4QqUQvXBe8iYe9axu3T1zRZZkUo2Jk8pP0MwmTkPwFR8OU1CTHvWnkGy7OFJ6yNoCqNbPC0ulh1g6ib16H4xj6Ekp46QV33TNNXY5qd9/8v+j21trnwxQ6hY69g55dgSE5L2uVHnwZ53pvfI+7m5FnByR6LBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966361; c=relaxed/simple;
	bh=BUa0EpqYWBifW3t7SsncrNUQFMrXEStr8ypDg3PMXHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvdsULuSqjiYaypQp/3aOW3uNaxwhKF9AcZX8ZPNuoZPq7F3cFiA60iis1VVdHTK1nIKr/sLaCnD93psyQMO9MfFMVFO0I+GXiOXY8kIU/cI31UZNg3Xn3z9Wvk3DnTqk1aX++AZcI/NH979ItdU92WqolMb4Ty9ZSOJ54HrsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIKKnBWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIKKnBWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36381C2BCB4;
	Tue,  5 May 2026 07:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966360;
	bh=BUa0EpqYWBifW3t7SsncrNUQFMrXEStr8ypDg3PMXHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIKKnBWGIatfh/ALKMPXv+/v5yS85mj7waSX58+382HHpDasGAwea3cjNU6EHLS6j
	 YEapEUYpPNJ+gcRmi9UrFGPz1P7vXnL20S9/RpQ/n0Oh7p4UEzMFUzncANE1qvTb5g
	 WK8/2X0rfzZW40JRQpqf8US1gQdhoyt0/xYwLf+Zg/mYqVof3R8m4bmkBdIBiwZahx
	 XBFsdQcN+mCT2FkOO303m/KZ/z0swN5E2YbF7LQTOLbVOyCdExtpZuYT0Ct3fldWSX
	 /karTvLbbioR3p5TUNLUkACxwQ4rPKloOhs0e+hMy8nRKe31NwuRHRPuu7xeWoiqlp
	 OionQAcmupPGQ==
Date: Tue, 5 May 2026 09:32:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: qcom-wdt: Add compatible for
 Nord watchdog
Message-ID: <20260505-rebel-honeybee-of-karma-06e43e@quoll>
References: <20260504081643.826038-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504081643.826038-1-shengchao.guo@oss.qualcomm.com>

On Mon, May 04, 2026 at 04:16:43PM +0800, Shawn Guo wrote:
> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> 
> Document Krait Processor Sub-system (KPSS) Watchdog timer on Nord SoC.
> 
> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

