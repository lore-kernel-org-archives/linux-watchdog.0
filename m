Return-path: <timur@codeaurora.org>
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Pratyush Anand <panand@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, fu.wei@linaro.org,
 Suravee.Suthikulpanit@amd.com, wim@iguana.be,
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
 Wim Van Sebroeck <wim@iguana.be>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <5728A7C3.4010001@roeck-us.net> <20160503143856.GE13045@dhcppc6.redhat.com>
 <5728BEC4.6050603@codeaurora.org> <20160503155141.GF13045@dhcppc6.redhat.com>
 <20160503171602.GA2518@roeck-us.net>
 <20160504141449.GG13045@dhcppc6.redhat.com> <572A0577.1070000@codeaurora.org>
 <20160504155932.GH13045@dhcppc6.redhat.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <572A2099.4070901@codeaurora.org>
Date: Wed, 4 May 2016 11:17:29 -0500
MIME-Version: 1.0
In-Reply-To: <20160504155932.GH13045@dhcppc6.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Pratyush Anand wrote:
> Its unique to SBSA because you have very little timeout here. kexec-tools
> upstream does not have any mechanism to handle watchdog timeout. Lets say even
> if we implement a framework there, the best it can do is to ping the watchdog
> again.

Ok, so it's more accurate to say that kexec has a minimum watchdog 
timeout requirement.  What happens if the system admin sets the timeout 
to 5 seconds arbitrarily?  The system will reset during kexec, no matter 
which hardware is used.

This still sounds like a band-aid to me.  We're just assuming that we 
need a timeout of at least 20 seconds to support kexec.  Frankly, this 
still sounds like a problem the kexec developers needs to acknowledge 
and deal with.

Still I'm okay with a patch that extends the timeout by programming WCV, 
but it has to be commented as a hack specifically to support kexec 
because the timeout might be too short.  Then Wim can decide whether he 
supports such changes.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
