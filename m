Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110D4BF923;
	Wed, 30 Sep 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768624; cv=none; b=fYQn+Jc7DrDtDelW9ON3H6IyPmczUEGEJnubwfd2fo53PrsuQP9HTgl3Wn3JFwnCCFz0wdPNW0JYowDHpqKnuF04Z/7InEzMtySbimF6gMYIxLDf0rk7SxY51wt2NGeEnf+TnH/OI6eiBGKyPWTrgwMky6CQSL1SlrV+E0dVDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768624; c=relaxed/simple;
	bh=EobKWXEIvBObH7lCIEsI1YDG35VifTWfBqASgq+A5t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaNHBpK4IAgyAlaSc/ArYM2WEWOpuJCSTkpYGnl9kZC52TBZYI41adHL1PQIMQWKChBlkAYewnOjwnaWJLSg5ltBhdKlM7eHp2/uXNlg0VYZ/PI53+nYJohXjL8gEscszvy+ABWEMGaZgGWp9UZRVY717bmMaffauzTLE2FFla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIuuhF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIuuhF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93B51F000FF;
	Wed, 30 Sep 2026 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768623;
	bh=yppF1OaGorQDiNY3DvD8WSBB77whKw7ij8k+uHMlFIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XwIuuhF62FZQPst4x7lJAk8seXIxor2L9DAgyIGt5YWuI4FWnvHl5ABq8VBruewNF
	 WvrHLLBAFriE0CCLNulOyNsOotxHRWbQ8drjzv9QKqtV+EH3hql/ItPyRG3WGnwgvO
	 CDzN4n+xCMpBztF85U7cH7xxNJKxNRLWZf8WcwIclPAj8z0BcHPr8qB98FFYiTj/Kk
	 wN3AoAdtlPTs+dZ/M2UuKX20oQIwl3tAX4CvSugPN3sbmoUjxlu4AInqcLhQLDWKXS
	 lt5C2fggjzX1BazdoAQthica7GipeBSRGyoNUX7luq5JeFbKoZ7cLGkwRDNd40lMJx
	 3hq/41NADSFOw==
Date: Wed, 30 Sep 2026 13:43:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: qcom-wdt: Document SM8750
 watchdog
Message-ID: <20260930-unyielding-archetypal-mussel-f8fbce@quoll>
References: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
 <20260929-sm8750-watchdog-v1-1-ea06d5dc7e54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-sm8750-watchdog-v1-1-ea06d5dc7e54@oss.qualcomm.com>

On Tue, Sep 29, 2026 at 04:01:21PM +0530, Komal Bajaj wrote:
> Add the SM8750 compatible string to Qualcomm watchdog binding.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

