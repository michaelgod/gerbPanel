%     Gerber 274X Panelization script
%     Copyright (C) 2013 TAO-YI LEE <tylee@ieee.org>
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

% THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED 
% WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
% IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
% INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
% HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
% IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.

function name = GerberPrepare(artwork)    
    [~, name, ~] = fileparts(artwork);
    if(exist([name '_apr.art'], 'file') && exist([name '_body.art'], 'file'))    
        disp('Preparation already done, skipping');
    else
        fid = fopen(artwork, 'r');  
        if(fid == -1)
            error(['File ' artwork ' cannot be opened']);
        end
        fid_apert = fopen([name '_apr.art'], 'w+');
        fid_body = fopen([name '_body.art'], 'w+');
        tline = fgets(fid);
        GerbLine(fid_apert, fid_body,  tline);   
        type = 1;
        while ischar(tline)        
            tline = fgets(fid);
            if(tline ~=-1)                    
                type  = GerbLine(fid_apert, fid_body,  tline, type);
            end        
        end
        fclose(fid);
        fclose(fid_apert);
        fclose(fid_body);
    end    
end